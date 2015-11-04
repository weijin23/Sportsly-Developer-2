//
//  FilteredPlayerClass.h
//  Wall
//
//  Created by Mindpace on 27/12/13.
//
//

#import <Foundation/Foundation.h>

@class AppDelegate;
@class NSFetchedResultsController;
@protocol FilteredPlayerClassProtocol <NSObject>

-(void)changedVales:(NSArray*)arrPlayerName :(NSArray*)arrPlayerId;

@end

@interface FilteredPlayerClass : NSObject <NSFetchedResultsControllerDelegate>

@property(nonatomic,strong) NSArray *alldelarr;
@property(nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

@property(nonatomic,weak) id <FilteredPlayerClassProtocol> delegate;

@property(nonatomic,weak) AppDelegate *appDelegate;

-(void)performFetch;
@end


