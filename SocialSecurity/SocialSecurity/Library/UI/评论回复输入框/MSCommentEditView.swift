//
//  MSCommentEditView.swift
//  MiddleSchool2_teacher
//
//  Created by 李琪 on 2017/5/18.
//  Copyright © 2017年 李琪. All rights reserved.
//

import UIKit

typealias MSCommentEditViewEditEndBlock = (_ didClickedSend:Bool, _ text:String) -> Void
class MSCommentEditView: UIView {
    let highLightLineColor = UIColor(hexString: "15b4ff")
    let defaultLineColor = UIColor(hexString: "757575")
    
    @IBOutlet var bottomLineLabel: UILabel!
    @IBOutlet var textView: UIPlaceholderTextView!
    @IBOutlet var sendButton: UIButton!
    
    var superView:UIView?
    var coverView:UIView!
    var editEndBlock:MSCommentEditViewEditEndBlock?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
//        textView.placeholder = "您的评论..."
    }
    
    func update(superView:UIView, editEndBlock:MSCommentEditViewEditEndBlock?){
        self.superView = superView
        initCoverView()
        self.editEndBlock = editEndBlock
    }
    
    func clearText(){
        textView.text = ""
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        textView.resignFirstResponder()
        
        editEndBlock?(true, textView.text)
        textView.text.removeAll()
    }
    
    @objc func coverViewTapped(){
        textView.resignFirstResponder()
        editEndBlock?(false,textView.text)
    }
    
    fileprivate func initCoverView(){
        layoutIfNeeded()
        coverView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: superView!.bounds.height - self.bounds.size.height))
//        coverView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.coverViewTapped))
        coverView.addGestureRecognizer(tap)
    }
}

extension MSCommentEditView : UITextViewDelegate{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        superView?.addSubview(coverView)
        bottomLineLabel.backgroundColor = highLightLineColor
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        coverView.removeFromSuperview()
        bottomLineLabel.backgroundColor = defaultLineColor
        return true
    }
    

}
