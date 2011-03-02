/*
 Copyright (c) 2011, Stefan Reitshamer http://www.haystacksoftware.com
 
 All rights reserved.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "FSNode.h"

@implementation FSNode
@synthesize path = _path, state = _state, isDirectory = _isDirectory;
@dynamic displayName, children;

- (id)initWithPath:(NSString *)thePath isDirectory:(BOOL)theIsDirectory {
    if (self = [super init]) {
        _path = [thePath retain];
        _isDirectory = theIsDirectory;
    }
    return self;
}
- (void)dealloc {
    [_path release];
    [_children release];
    [super dealloc];
}
- (NSString *)displayName {
    return [_path lastPathComponent];
}
- (NSArray *)children {
    if (_children == nil) {
        NSMutableArray *newChildren = [NSMutableArray array];
        NSError *myError = nil;
        NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:_path error:&myError];
        if (contents == nil) {
            NSLog(@"%@", myError);
            return nil;
        }
        NSMutableArray *sorted = [NSMutableArray arrayWithArray:contents];
        [sorted sortUsingSelector:@selector(caseInsensitiveCompare:)];
        for (NSString *name in sorted) {
            NSString *childPath = [_path stringByAppendingPathComponent:name];
            BOOL isDir = NO;
            [[NSFileManager defaultManager] fileExistsAtPath:childPath isDirectory:&isDir];
            FSNode *childNode = [[[FSNode alloc] initWithPath:childPath isDirectory:isDir] autorelease];
            [newChildren addObject:childNode];
        }
        _children = [newChildren retain];
    }
    
    return _children;
}
@end
