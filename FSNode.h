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

#import <Cocoa/Cocoa.h>

@class BackupConfig;

// This is a simple wrapper around the file system. Its main purpose is to cache children.
@interface FSNode : NSObject {
@private
    NSString *_path;
    BOOL _isDirectory;
    NSArray *_children;
    NSInteger _state;
}

// The designated initializer
- (id)initWithPath:(NSString *)thePath isDirectory:(BOOL)theIsDirectory;

@property(readonly, copy) NSString *path;
@property(readonly, copy) NSString *displayName;
@property NSInteger state;
@property(readonly) BOOL isDirectory;
@property(readonly, retain) NSArray *children;
@end
