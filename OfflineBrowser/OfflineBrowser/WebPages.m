/*********************************************************************************************
*   OFFLINE BROWSER:    WebPages                                                             *
*                                                                                            *
* Authors:     Greg Murray and Shaun Ready                                                   *
* Last Edit:   March 30, 2012                                                                *
*                                                                                            *
* Description: WebPages is a singleton that contains the web pages that are displayed in the *
*              SavedScreenController. Methods are provided to save and load archived data.   *
**********************************************************************************************/

#import "WebPages.h"

static WebPages *defaultPages = nil;

@implementation WebPages

+(WebPages *)defaultPages
{
    if(!defaultPages)
        defaultPages = [[super allocWithZone:NULL] init];
    
    return defaultPages;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [self defaultPages];
}

-(id)init
{
    if(defaultPages)
        return defaultPages;
    
    self = [super init];
    return self;
}

-(NSMutableArray *)allPages
{
    return allPages;
}

/* Add a page to allPages
 ************************************/
-(Page *)addPageURL:(NSString *)pageURL html:(NSString *)pageHTML
{
    Page *newPage = [[Page alloc] init];
    [newPage setPageURL:pageURL];
    [newPage setPageHTML:pageHTML];
    
    if ([allPages count] == 0)
        [allPages addObject:newPage];
    else
    {
        int i=0;
        while (i < [allPages count] && ![[[allPages objectAtIndex:i] pageURL] isEqualToString:pageURL])
            i++;
    
        if (i < [allPages count] && [[[allPages objectAtIndex:i] pageURL] isEqualToString:pageURL]) //Already exists
            [[allPages objectAtIndex:i] setPageHTML:pageHTML]; //Update HTML
        else
            [allPages addObject:newPage];
    }
    return newPage;
}

/* Archive the web pages
 ************************************/
-(void)savePages
{
    NSString *path = [self getArchivePath];
    [NSKeyedArchiver archiveRootObject:allPages toFile:path];
}

/* Unarchive the saved data
 ************************************/
-(void)loadPages
{
    if(!allPages)
    {
        NSString *path = [self getArchivePath];
        allPages = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    
    if(!allPages)
        allPages = [[NSMutableArray alloc] init];
}

/* Get the path to the location where the data will be saved and loaded from
 ************************************************************************************/
-(NSString *)getArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSString *path = [documentDirectory stringByAppendingPathComponent:@"savedPages.data"];
    
    return path;
}



@end
