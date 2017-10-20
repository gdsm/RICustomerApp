//
//  DatabaseManager.m
//  ReddyIce
//
//  Created by Gagan on 09/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import "DatabaseManager.h"
#import "Globals.h"


#define MANAGED_CONTEXT_KEY_NAME @"ManagedObjectContext"

NSString* const currentCoreDataVersion = @"1.0000";
NSString* const coreDataHiddenDirectory = @".data";
NSString* const coreDataDBName = @"Core_Data.sqlite";

NSString* const kCDInstalledVersion = @"CoreDataVersion";
NSString* const kCurrentCoreBackup = @"original.sqlite.backup";
NSString* const kCurrentCoreSHMBackup = @"original.sqlite-shm.backup";
NSString* const kCurrentCoreWALBackup = @"original.sqlite-wal.backup";


@interface DatabaseManager ()
@property (nonatomic, strong) NSManagedObjectModel* managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator* persistentStoreCoordinator;
@end


@implementation DatabaseManager

+ (DatabaseManager *) shared
{
    __strong static DatabaseManager * _databaseManager_sharedInstance = nil;
    
    static dispatch_once_t databaseManager_SharedDispatchOnceToken = 0;
    dispatch_once(&databaseManager_SharedDispatchOnceToken, ^{
        _databaseManager_sharedInstance = [DatabaseManager new];
    });
    
    return _databaseManager_sharedInstance;
}

- (NSString *)fullCoreDataPath
{
    if (_fullCoreDataPath == nil)
    {
        NSString* documentDir = [Globals shared].documentsDirectory;
//        self.fullCoreDataPath = [[documentDir stringByAppendingPathComponent:coreDataHiddenDirectory] stringByAppendingPathComponent:coreDataDBName];
        self.fullCoreDataPath = [documentDir stringByAppendingPathComponent:coreDataDBName];
    }
    return _fullCoreDataPath;
}

- (NSManagedObjectContext *) managedObjectContext
{
    // NOTE: Core Data managed object contexts are NOT thread-safe. Therefore, the safest
    // approach is to create a NSManagedObjectContext for each thread and store it in
    // each thread's threadDictionary collection. The NSPersistentStoreCoordinator can
    // be shared by multiple contexts across multiple threads.
    NSThread* currentThread = [NSThread currentThread];
    NSMutableDictionary *threadDictionary = [currentThread threadDictionary];
    NSManagedObjectContext *managedObjectContext = [threadDictionary objectForKey:MANAGED_CONTEXT_KEY_NAME];
    
    if (managedObjectContext != nil)
    {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        managedObjectContext.persistentStoreCoordinator = coordinator;
        
        // If this is not the main thread, set the staleness interval on the context to 0.0 so that
        // fetches will always retrieve the latest data from the persistent store instead of using cached
        // data.
        if (!currentThread.isMainThread)
        {
            managedObjectContext.stalenessInterval = 0.0;
        }
        
        [threadDictionary setObject:managedObjectContext forKey:MANAGED_CONTEXT_KEY_NAME];
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath:self.fullCoreDataPath];
    NSError *error = nil;

    //NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
    //                         [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
    //                         [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSDictionary *options = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:[self managedObjectModel]];
    
     NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error];
    BOOL isSuccess = (store != nil);
    if(!isSuccess)
    {
        // log error
    }
    
    return _persistentStoreCoordinator;
}

- (void) deleteEntities:(NSArray *)deleted ofType:(NSString *)eType predicateFormat:(NSString *)format
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:eType];
    
    if (deleted && [deleted count])
    {
        for (NSString *delItem in deleted)
        {
////            [SilverLog level:SilverLogLevelInfo message:@"Going to delete %@ %@", eType, delItem];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:format, delItem];
            [request setPredicate:predicate];
            
            NSError *error = nil;
            NSArray *fetchResults = [self.managedObjectContext executeFetchRequest:request error:&error];
            
            if ([fetchResults count] > 0)
            {
                for (NSManagedObject *item in fetchResults)
                {
                    [self.managedObjectContext deleteObject:item];
////                    [SilverLog level:SilverLogLevelInfo message:@"%@ %@ was deleted", eType, delItem];
                }
            }
        }
    }
    
}

- (NSManagedObject *) newOrExistingEntity:(NSPredicate *)predicate ofType:(NSString *)eType reuseRequest:(NSFetchRequest **)incomingRequest codeNSLog:(NSString *)code
{
    NSFetchRequest *request = *incomingRequest ? *incomingRequest : [[NSFetchRequest alloc] initWithEntityName:eType];
    [request setPredicate:predicate];
    [request setFetchLimit:1];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if (!mutableFetchResults)
    {
////        [SilverLog level:SilverLogLevelError message:@"Error looking up existing %@: %@", eType, error];
        abort();
    }
    
    NSManagedObject *item = nil;
    if ([mutableFetchResults count]) // this item already exists;
    {
        item = [mutableFetchResults objectAtIndex:0];
////        [SilverLog level:SilverLogLevelDebug message:@"Updating %@ %@", eType, code];
    }
    else
    {
////        [SilverLog level:SilverLogLevelDebug message:@"Adding %@ %@", eType, code];
        item = [NSEntityDescription insertNewObjectForEntityForName:eType inManagedObjectContext:self.managedObjectContext];
    }
    
    return item;
}

- (NSManagedObject *) newOrExistingEntity:(NSString *)code ofType:(NSString *)eType predicateFormat:(NSString *)format reuseRequest:(NSFetchRequest **)incomingRequest
{
    return [self newOrExistingEntity:[NSPredicate predicateWithFormat:format, code] ofType:eType reuseRequest:incomingRequest codeNSLog:code];
}


- (void) deleteAllEntitiesOfType:(NSString *)eType
{
////    [SilverLog level:SilverLogLevelDebug message:@"Deleting all %@", eType];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:eType];
    
    NSError *error = nil;
    NSArray *fetchResults = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    for (NSManagedObject *obj in fetchResults)
    {
        [self.managedObjectContext deleteObject:obj];
    }
}

- (BOOL) tryToUpgradeCoreData
{
    BOOL isSuccess = NO;
    NSString *installedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kCDInstalledVersion];
    BOOL wipeNeeded = YES;

    if ([installedVersion isEqualToString:@"0.9999"])
    {
        /* This is the first install of application. So no migration required. The below code will never execute it is for refrence.
        
        BOOL success = [self migrateCoreDataFromModel:@"0.9999"];
        if (!success)
        {
            NSLog(@"Error in converting coredata database from 0.987");
            return NO;
        }
        wipeNeeded = NO;
         */
    }
    
    if (![installedVersion isEqualToString:currentCoreDataVersion])
    {
        if (wipeNeeded)
        {
            [self clearExistingCoreData];
        }
        else
        {
            NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
            [def setObject:currentCoreDataVersion forKey:@"CoreDataVersion"];
            [def synchronize];
        }
    }

    return isSuccess;
}

- (void) clearExistingCoreData
{
    BOOL isBaseFile;
    BOOL isSHMFile;
    BOOL isWALFile;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    isBaseFile = [fileManager fileExistsAtPath:self.fullCoreDataPath];
    if (isBaseFile)
    {
        [fileManager removeItemAtPath:self.fullCoreDataPath error:nil];
    }
    
    NSString *shmFile = [self.fullCoreDataPath stringByAppendingString:@"-shm"];
    isSHMFile = [fileManager fileExistsAtPath:shmFile];
    if (isSHMFile)
    {
        [fileManager removeItemAtPath:shmFile error:nil];
    }
    
    NSString *walFile = [self.fullCoreDataPath stringByAppendingString:@"-wal"];
    isWALFile = [fileManager fileExistsAtPath:walFile];
    if (isWALFile)
    {
        [fileManager removeItemAtPath:walFile error:nil];
    }
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:currentCoreDataVersion forKey:@"CoreDataVersion"];
    [def synchronize];
}

- (BOOL) migrateCoreDataFromModel:(NSString *)fromModelName
{
    NSError *error = nil;
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    NSString *oldPath = [[NSBundle mainBundle] pathForResource:fromModelName ofType:@"mom"];
    NSManagedObjectModel *fromModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:oldPath]];
    
    NSMappingModel *mappingModel = [NSMappingModel inferredMappingModelForSourceModel:fromModel destinationModel:[self managedObjectModel] error:&error];
    if (error)
    {
        NSString *msg = [NSString stringWithFormat:@"Inferring failed %@ [%@]", [error description], ([error userInfo] ? [[error userInfo] description] : @"no user info")];
        NSLog(@"Log Message : %@", msg);
        return NO;
    }
    
    // backup sensitive data
    NSString *currentCore    = self.fullCoreDataPath;
    NSString *currentCoreSHM = [currentCore stringByAppendingString:@"-shm"];
    NSString *currentCoreWAL = [currentCore stringByAppendingString:@"-wal"];
    NSURL    *currentCoreURL = [NSURL fileURLWithPath:self.fullCoreDataPath];
    
    NSString *currentCoreBackupPath    = [[Globals shared].documentsDirectory stringByAppendingPathComponent:kCurrentCoreBackup];
    NSString *currentCoreSHMBackupPath = [[Globals shared].documentsDirectory stringByAppendingPathComponent:kCurrentCoreSHMBackup];
    NSString *currentCoreWALBackupPath = [[Globals shared].documentsDirectory stringByAppendingPathComponent:kCurrentCoreWALBackup];
    
    
    if (![self backupFileAtPath:currentCore toPath:currentCoreBackupPath error:&error])
    {
        return NO;
    }
    if (![self backupFileAtPath:currentCoreSHM toPath:currentCoreSHMBackupPath error:&error])
    {
        return NO;
    }
    if (![self backupFileAtPath:currentCoreWAL toPath:currentCoreWALBackupPath error:&error])
    {
        return NO;
    }
    
    // first clean up any temp files that were left.
    NSString *tempCore    = [[Globals shared].documentsDirectory stringByAppendingPathComponent:@"updatedCoreData.sqlite"];
    NSString *tempCoreSHM = [tempCore stringByAppendingString:@"-shm"];
    NSString *tempCoreWAL = [tempCore stringByAppendingString:@"-wal"];
    NSURL    *tempCoreURL = [NSURL fileURLWithPath:tempCore];
    
    if (![self removeItemAtPath:tempCore error:&error fileManager:filemanager])
    {
        return NO;
    }
    if (![self removeItemAtPath:tempCoreSHM error:&error fileManager:filemanager])
    {
        return NO;
    }
    if (![self removeItemAtPath:tempCoreWAL error:&error fileManager:filemanager])
    {
        return NO;
    }
    
    NSLog(@"Temporary core : %@", tempCore);
    
    // let's go ahead and migrate
    NSValue *classValue = [[NSPersistentStoreCoordinator registeredStoreTypes] objectForKey:NSSQLiteStoreType];
    Class sqliteStoreClass = (Class)[classValue pointerValue];
    Class sqliteStoreMigrationManagerClass = [sqliteStoreClass migrationManagerClass];
    
    NSMigrationManager *manager = [[sqliteStoreMigrationManagerClass alloc] initWithSourceModel:fromModel destinationModel:[self managedObjectModel]];
    
    if (![manager migrateStoreFromURL:currentCoreURL
                                 type:NSSQLiteStoreType
                              options:nil
                     withMappingModel:mappingModel
                     toDestinationURL:tempCoreURL
                      destinationType:NSSQLiteStoreType
                   destinationOptions:nil
                                error:&error])
    {
        NSString *msg = [NSString stringWithFormat:@"Migration failed %@ [%@]",
                         [error description],
                         ([error userInfo] ? [[error userInfo] description] : @"no user info")];
        NSLog(@"Failure Message : %@", msg);
        return NO;
    }
    
    if (![self replaceItemAtPath:currentCore
                  withItemAtPath:tempCore
                     fileManager:filemanager
                           error:&error])
    {
        // couldn't replace the file.
        [self revertCoreFiles:@[currentCore, currentCoreSHM, currentCoreWAL]
              withBackupFiles:@[currentCoreBackupPath, currentCoreSHMBackupPath, currentCoreWALBackupPath]];
        return NO;
    }
    
    if (![self replaceItemAtPath:currentCoreSHM
                  withItemAtPath:tempCoreSHM
                     fileManager:filemanager
                           error:&error])
    {
        // couldn't replace the file.
        [self revertCoreFiles:@[currentCore, currentCoreSHM, currentCoreWAL]
              withBackupFiles:@[currentCoreBackupPath, currentCoreSHMBackupPath, currentCoreWALBackupPath]];
        return NO;
    }
    
    if (![self replaceItemAtPath:currentCoreWAL
                  withItemAtPath:tempCoreWAL
                     fileManager:filemanager
                           error:&error])
    {
        // couldn't replace the file.
        [self revertCoreFiles:@[currentCore, currentCoreSHM, currentCoreWAL]
              withBackupFiles:@[currentCoreBackupPath, currentCoreSHMBackupPath, currentCoreWALBackupPath]];
        return NO;
    }
    
    // finally, lets remove the backups.
    // if it doesn't work, it should be okay. they will be removed the next time we try to do an upgrade.
    [self removeItemAtPath:currentCoreBackupPath error:&error fileManager:filemanager];
    [self removeItemAtPath:currentCoreSHMBackupPath error:&error fileManager:filemanager];
    [self removeItemAtPath:currentCoreWALBackupPath error:&error fileManager:filemanager];
    
    NSLog(@"Core Data upgraded Successfully");
    
    return YES;
}

- (BOOL) backupFileAtPath:(NSString *)srcPath toPath:(NSString *)dscPath error:(NSError **)error
{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    if ([fm fileExistsAtPath:srcPath])
    {
        if ([fm fileExistsAtPath:dscPath])
        {
            if (![fm removeItemAtPath:dscPath error:error])
            {
                NSString *msg = [NSString stringWithFormat:@"back up failed: Unable to remove file:%@\n%@ [%@]",
                                 dscPath,
                                 [*error description],
                                 ([*error userInfo] ? [[*error userInfo] description] : @"no user info")];
                
                NSLog(@"Failed to remove file : %@", msg);
                return NO;
            }
        }
        
        if (![fm copyItemAtPath:srcPath toPath:dscPath error:error]) {
            NSString *msg = [NSString stringWithFormat:@"back up failed: Unable to copy file:%@\n%@ [%@]",
                             dscPath,
                             [*error description],
                             ([*error userInfo] ? [[*error userInfo] description] : @"no user info")];
            
            NSLog(@"Failed to copy file : %@", msg);
            return NO;
        }
    }
    
    return YES;
}

- (BOOL) revertCoreFiles:(NSArray *)coreFiles withBackupFiles:(NSArray *)backFiles
{
    if (coreFiles.count != backFiles.count)
    {
        NSString *msg = [NSString stringWithFormat:@"revert failed: different coreFiles/backFiles count. coreFiles: %li, backFiles: %li",
                         (long)coreFiles.count, (long)backFiles.count];
        
        NSLog(@"Failed to copy file : %@", msg);
        return NO;
    }
    
    
    NSError *error;
    NSFileManager *fm = [NSFileManager defaultManager];
    
    for (NSString *coreFile in coreFiles)
    {
        if ([fm fileExistsAtPath:coreFile])
        {
            if (![fm removeItemAtPath:coreFile error:&error])
            {
                NSString *msg = [NSString stringWithFormat:@"revert failed: Unable to remove file:%@\n%@ [%@]",
                                 coreFile,
                                 [error description],
                                 ([error userInfo] ? [[error userInfo] description] : @"no user info")];
                
                NSLog(@"Failed to remove file : %@", msg);
                continue;
            }
        }
        
        NSUInteger index = [coreFiles indexOfObject:coreFile];
        if (![fm copyItemAtPath:backFiles[index] toPath:coreFile error:&error])
        {
            NSString *msg = [NSString stringWithFormat:@"revert failed: Unable to copy file:%@\n%@ [%@]",
                             coreFile,
                             [error description],
                             ([error userInfo] ? [[error userInfo] description] : @"no user info")];
            
            NSLog(@"Failed to copy file : %@", msg);
            continue;
        }
    }
    
    return YES;
}

- (BOOL) removeItemAtPath:(NSString *)path error:(NSError **)error fileManager:(NSFileManager *)fileManager
{
    if ([fileManager fileExistsAtPath:path isDirectory:nil])
    {
        if (![fileManager removeItemAtPath:path error:error]) {
            NSString *msg = [NSString stringWithFormat:@"Clean up Failed:Unable to remove file:%@\n%@ [%@]",
                             path,
                             [*error description],
                             ([*error userInfo] ? [[*error userInfo] description] : @"no user info")];
            
            NSLog(@"Failed to remove file : %@", msg);
            return NO;
        }
    }
    
    return YES;
}

- (BOOL) replaceItemAtPath:(NSString *)originalItemPath
            withItemAtPath:(NSString *)newItemPath
               fileManager:(NSFileManager *)fileManager
                     error:(NSError **)error
{
    if ([fileManager fileExistsAtPath:newItemPath isDirectory:nil]) {
        NSURL *originalURL = [NSURL fileURLWithPath:originalItemPath];
        NSURL *newItemURL = [NSURL fileURLWithPath:newItemPath];
        NSURL *resultingURL;
        
        if (![fileManager replaceItemAtURL:originalURL
                             withItemAtURL:newItemURL
                            backupItemName:nil
                                   options:NSFileManagerItemReplacementUsingNewMetadataOnly | NSFileManagerItemReplacementWithoutDeletingBackupItem
                          resultingItemURL:&resultingURL
                                     error:error])
        {
            NSString *msg = [NSString stringWithFormat:@"Replace Item Failed: %@\n%@ [%@]",
                             originalItemPath,
                             [*error description],
                             ([*error userInfo] ? [[*error userInfo] description] : @"no user info")];
            
            NSLog(@"Failed to replace file : %@", msg);
            return NO;
        }
    }
    
    return YES;
}

- (void) saveChangesAsynchronously
{
    __weak DatabaseManager* weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weakSelf.managedObjectContext performBlockAndWait:^{
            [weakSelf saveChanges];
        }];
        
    });
}

- (void) saveChanges
{
    NSError *error = nil;
    
    // From http://stackoverflow.com/a/1297157/4479896
    if (![self.managedObjectContext save:&error])
    {
        abort();
    }
}

@end
