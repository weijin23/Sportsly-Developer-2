//
//  FilteredPlayerClass.m
//  Wall
//
//  Created by Mindpace on 27/12/13.
//
//

#import "FilteredPlayerClass.h"
#import "AppDelegate.h"
#import "Event.h"
@implementation FilteredPlayerClass

@synthesize fetchedResultsController,delegate,alldelarr,appDelegate;


-(void)performFetch
{
    self.appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    
    [self fetchedResultsController];
    
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController != nil)
    {
        NSMutableArray *arr1=[[fetchedResultsController fetchedObjects] mutableCopy];
        self.alldelarr=arr1;
        
         [self filteredArray];
        return fetchedResultsController;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    // Set up the fetched results controller.
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:EVENT inManagedObjectContext:self.appDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
    // [fetchRequest setReturnsObjectsAsFaults:NO];
    // Set the batch size to a suitable number.
    // [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSPredicate *pre=nil;
    
    
   
            pre=[NSPredicate predicateWithFormat:@"(userId==%@)",[appDelegate.aDef objectForKey:LoggedUserID]];// AND (isPublic==1)
        
        
    
  
    
    
    
    
    [fetchRequest setPredicate:pre];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:NO /*selector:@selector(localizedCaseInsensitiveCompare:)*/];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    //
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil] ;//@"eventDateString"
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    // NSLog(@"TodosByEventsFetchesNumberCheck=%@",[fetchedResultsController fetchedObjects]);
    
    /* NSArray *arrrr=[fetchedResultsController fetchedObjects];
     
     [arrrr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
     Event *event=(Event*)obj;
     
     NSLog(@"%@-%@",event.eventDateString,event.eventName);
     
     }];*/
    //////
    /*
     __block  Event *ev=nil;
     NSArray *  arrrr=  [self.fetchedResultsController sections];
     int i=0;
     for( id <NSFetchedResultsSectionInfo> sectionInfo in arrrr)
     {
     
     
     NSLog(@"NOF=%i----Section=%i",[sectionInfo numberOfObjects],i);
     
     
     
     NSArray *arr=[sectionInfo objects];
     [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
     Event *event=(Event*)obj;
     
     NSLog(@"%@-%@",event.eventDateString,event.eventName);
     
     
     if(i==1)
     ev=event;
     
     if(i==2)
     {
     if([ev.eventDateString isEqualToString:event.eventDateString])
     {
     NSLog(@"%i",1);
     }
     else
     {
     NSLog(@"%i",0);
     }
     }
     }];
     
     i++;
     }
     */
    ////////
    
    
    
    NSArray *arr= [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil ];
    
   
       self.alldelarr=arr;
    // NSLog(@"FetchedObjects=%@",arr);
    
    /* for(Event *ev in arr)
     {
     NSLog(@"StartTime=%@",ev.startTime);
     }*/
    
   [self filteredArray];
    
    return fetchedResultsController;
}




-(void)filteredArray
{
    
    NSArray *arr= [[NSSet setWithArray:[self.alldelarr valueForKeyPath:@"playerId"]] allObjects];
       NSLog(@"FilteredArray1=%@",arr);
    
    NSArray *arr1= [[NSSet setWithArray:[self.alldelarr valueForKeyPath:@"playerName"]] allObjects];
    NSLog(@"FilteredArray1=%@",arr);
    
    NSMutableArray *arrmu=[[NSMutableArray alloc] init];
    
     NSMutableArray *arrmu1=[[NSMutableArray alloc] init];
    
   /* for(Event *ev in arr)
    {
        [arrmu addObject:ev.playerName];
        
        [arrmu1 addObject:ev.playerId];
    }*/
    
    
    for(id st in arr)
    {
        
        if(![st isMemberOfClass:[NSNull class]])
        {
            [arrmu addObject:st];
            
            for(Event *ev in self.alldelarr)
            {
                
                if([st isEqualToString:ev.playerId])
                {
                    [arrmu1 addObject:ev.playerName];
                    
                    break;
                }
                
            }
            
            
        }
        
    }
    
    
    NSLog(@"FilteredArray2=%@----%@",arr,arr1);
    
    [delegate changedVales:arrmu1:arrmu];
    
}





- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
       
    if(self.fetchedResultsController.fetchedObjects.count>0)
    {
        [self filteredArray];
    }
  
}



@end
