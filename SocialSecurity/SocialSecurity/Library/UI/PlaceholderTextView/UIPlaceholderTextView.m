#import "UIPlaceholderTextView.h"

@interface UIPlaceholderTextView ()

@property (nonatomic, strong) UIColor* textColor;

- (void) beginEditing:(NSNotification*) notification;
- (void) endEditing:(NSNotification*) notification;

@end

@implementation UIPlaceholderTextView
@synthesize placeholder;
@synthesize textColor;
- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}
//当用nib创建时会调用此方法
- (void)awakeFromNib {
    textColor = [UIColor darkGrayColor];
    [super awakeFromNib];
    [self addObserver];
}
-(void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}
-(void)removeobserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Setter/Getters
- (void) setPlaceholder:(NSString *)aPlaceholder {
    placeholder = aPlaceholder;
    [self endEditing:nil];
}

- (NSString *) text {
    NSString* text = [super text];
    if ([text isEqualToString:placeholder]) return @"";
    
    return text;
}
-(void)setText:(NSString *)text{
    super.text = text;
    //字体颜色
    [super setTextColor:textColor];
}

- (void) beginEditing:(NSNotification*) notification {
    if ([super.text isEqualToString:placeholder]) {
        super.text = nil;
        //字体颜色
        [super setTextColor:textColor];
    }
    
}

- (void) endEditing:(NSNotification*) notification {
    if ([super.text isEqualToString:@""] || self.text == nil) {
        super.text = placeholder;
        //注释颜色
        [super setTextColor:[UIColor lightGrayColor]];
    }
}
@end
