//
//  DatabaseManager.h
//  ReddyIce
//
//  Created by Gagan on 09/10/17.
//  Copyright © 2017 HCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

extern NSString* const currentCoreDataVersion;

@interface DatabaseManager : NSObject

+ (DatabaseManager *) shared;

@property (nonatomic, strong) NSString *fullCoreDataPath;
@property (nonatomic, strong, readonly) NSManagedObjectContext* managedObjectContext;

- (void) deleteEntities:(NSArray *)deleted ofType:(NSString *)eType predicateFormat:(NSString *)format;
- (NSManagedObject *) newOrExistingEntity:(NSString *)code ofType:(NSString *)eType predicateFormat:(NSString *)format reuseRequest:(NSFetchRequest **)request;
- (NSManagedObject *) newOrExistingEntity:(NSPredicate *)predicate ofType:(NSString *)eType reuseRequest:(NSFetchRequest **)incomingRequest codeNSLog:(NSString *)code;
- (void) deleteAllEntitiesOfType:(NSString *)eType;

- (void) clearExistingCoreData;
- (BOOL) tryToUpgradeCoreData;

- (void) saveChangesAsynchronously;
- (void) saveChanges;

@end
