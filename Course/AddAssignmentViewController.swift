//
//  AddAssignmentViewController.swift
//  Course
//
//  Created by Archie Yu on 2016/11/21.
//  Copyright © 2016年 Archie Yu. All rights reserved.
//

import UIKit
import CourseModel

class AddAssignmentViewController : UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var year = 0
    let max = 16384
    
    var editingItem = ""
    
    var courseOldFrame : CGRect!
    var timeOldFrame : CGRect!
    
    var courseVC : ChooseCourseViewController!
    var timeVC : ChooseTimeViewController!
    
    @IBOutlet weak var shadow: UIButton!
    @IBOutlet weak var courseView: UIView!
    @IBOutlet weak var courseButton: UIButton!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var beginTimeButton: UIButton!
    @IBOutlet weak var endTimeButton: UIButton!
    @IBOutlet weak var contentField: UITextField!
    @IBOutlet weak var contentBackground: UILabel!
    @IBOutlet weak var notePlaceHolder: UILabel!
    @IBOutlet weak var noteText: UITextView!
    @IBOutlet weak var noteBackground: UILabel!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var courseViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var courseViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // 在子控制器中找到课程选择界面和时间选择界面对应的控制器
        for vc in self.childViewControllers {
            switch vc {
            case is ChooseCourseViewController: courseVC = vc as! ChooseCourseViewController
            case is ChooseTimeViewController: timeVC = vc as! ChooseTimeViewController
            default: break
            }
        }
        
        // 保存课程选择界面和时间选择界面的初始大小，方便视图变化结束后恢复
        timeOldFrame = timeView.frame
        courseOldFrame = courseView.frame
        
        // 在编辑某一项信息时，用阴影遮盖其他部分
        shadow.backgroundColor = UIColor.black
        shadow.alpha = 0
        
        contentField.delegate = self
        noteText.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // 注册键盘出现和键盘消失的通知
        let NC = NotificationCenter.default
        NC.addObserver(self,
                       selector: #selector(AddAssignmentViewController.keyboardWillShow(notification:)),
                       name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NC.addObserver(self,
                       selector: #selector(AddAssignmentViewController.keyboardWillHide(notification:)),
                       name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // 注销键盘出现和键盘消失的通知
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseCourse(_ sender: UIButton) {
        
        editingItem = "course"
        
        // 将阴影和当前编辑视图前置
        self.view.bringSubview(toFront: shadow)
        self.view.bringSubview(toFront: courseView)
        
        // 计算视图弹出时应该变化的大小
        let newSize = courseVC!.beginChooseCourse()
//        let newPos = CGPoint(x: courseView.frame.minX, y: self.view.frame.height / 2 - newSize.height / 2)
//        let newFrame = CGRect(origin: newPos, size: newSize)
        
        // 渐变
        courseViewHeightConstraint.constant = newSize.height
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.shadow.alpha = 0.7
            self.view.layoutIfNeeded()
        })
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(0.3)
//        shadow.alpha = 0.7
//        courseView.frame = newFrame
//        UIView.commitAnimations()
        
    }
    
    @IBAction func chooseBeginTime(_ sender: UIButton) {
        
        editingItem = "beginTime"
        
        // 开始时间选择器和结束时间选择器共享，利用editingItem进行区分
        timeVC?.editingItem = "beginTime"
        
        // 将阴影和当前编辑视图前置
        self.view.bringSubview(toFront: shadow)
        self.view.bringSubview(toFront: timeView)
        
        // 计算视图弹出时应该变化的大小
        let newSize = timeVC!.beginChooseTime()
//        let newPos = CGPoint(x: courseView.frame.minX, y: self.view.frame.height / 2 - newSize.height / 2)
//        let newFrame = CGRect(origin: newPos, size: newSize)
        
        // 渐变
        timeViewHeightConstraint.constant = newSize.height
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.shadow.alpha = 0.7
            self.view.layoutIfNeeded()
        })
//        UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(0.2)
//        shadow.alpha = 0.7
//        timeView.frame = newFrame
//        UIView.commitAnimations()
        
    }
    
    @IBAction func chooseEndTime(_ sender: UIButton) {
        
        editingItem = "endTime"
        
        // 开始时间选择器和结束时间选择器共享，利用editingItem进行区分
        timeVC?.editingItem = "endTime"
        
        // 将阴影和当前编辑视图前置
        self.view.bringSubview(toFront: shadow)
        self.view.bringSubview(toFront: timeView)
        
        // 计算视图弹出时应该变化的大小
        let newSize = timeVC!.beginChooseTime()
        //        let newPos = CGPoint(x: courseView.frame.minX, y: self.view.frame.height / 2 - newSize.height / 2)
        //        let newFrame = CGRect(origin: newPos, size: newSize)
        
        // 渐变
        timeViewHeightConstraint.constant = newSize.height
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.shadow.alpha = 0.7
            self.view.layoutIfNeeded()
        })
        //        UIView.beginAnimations(nil, context: nil)
        //        UIView.setAnimationDuration(0.2)
        //        shadow.alpha = 0.7
        //        timeView.frame = newFrame
        //        UIView.commitAnimations()
        
    }
    
    @IBAction func editContent(_ sender: UITextField) {
        
        editingItem = "content"
        
        // 将阴影和当前编辑视图前置
        self.view.bringSubview(toFront: shadow)
        self.view.bringSubview(toFront: contentBackground)
        self.view.bringSubview(toFront: contentField)
        
        // 渐变
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2)
        shadow.alpha = 0.7
        UIView.commitAnimations()
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        editingItem = "note"
        
        noteText.text = ""
        noteText.textColor = .black
        
        // 将阴影和当前编辑视图前置
        self.view.bringSubview(toFront: shadow)
        self.view.bringSubview(toFront: noteBackground)
        self.view.bringSubview(toFront: noteText)
        self.view.bringSubview(toFront: notePlaceHolder)
        
        // 渐变
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2)
        shadow.alpha = 0.7
        UIView.commitAnimations()
        
        return true
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        notePlaceHolder.isHidden = (noteText.text != "")
    }
    
    @IBAction func endEdit(_ sender: UIControl) {
        
        // 恢复前置区域
        self.view.bringSubview(toFront: courseButton)
        self.view.bringSubview(toFront: beginTimeButton)
        self.view.bringSubview(toFront: endTimeButton)
        self.view.bringSubview(toFront: navigationBar)
        
        // 根据正在编辑的区域恢复视图
        switch editingItem {
        case "course":
            courseVC!.endChooseCourse()
//            UIView.beginAnimations(nil, context: nil)
//            UIView.setAnimationDuration(0.3)
//            shadow.alpha = 0
//            courseView.frame = courseOldFrame
//            UIView.commitAnimations()
            courseViewHeightConstraint.constant = courseOldFrame.height
            UIView.animate(withDuration: 0.3, animations: {() -> Void in
                self.shadow.alpha = 0
                self.view.layoutIfNeeded()
            })
        case "beginTime", "endTime":
            timeVC!.endChooseTime()
//            UIView.beginAnimations(nil, context: nil)
//            UIView.setAnimationDuration(0.2)
//            shadow.alpha = 0
//            timeView.frame = timeOldFrame
//            UIView.commitAnimations()
            timeViewHeightConstraint.constant = timeOldFrame.height
            UIView.animate(withDuration: 0.3, animations: {() -> Void in
                self.shadow.alpha = 0
                self.view.layoutIfNeeded()
            })
        case "content":
            finishInput(contentField)
        case "note":
            finishInput(noteText)
        default: break
        }
        
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            // 计算可能需要上移的距离
            let keyboardHeight = keyboardFrame.origin.y
            var deltaY : CGFloat = 0
            switch(editingItem) {
            case "content":
                let contentHeight = contentField.frame.maxY
                deltaY = keyboardHeight - contentHeight - 10
            case "note":
                let noteHeight = noteText.frame.maxY
                deltaY = keyboardHeight - noteHeight - 10
            default: break
            }
            // 需要上移时，变化视图位置
            if deltaY < 0 {
//                var frame = self.view.frame
//                frame.origin.y = deltaY
//                self.view.frame = frame
                courseViewTopConstraint.constant = 60 + deltaY
                UIView.animate(withDuration: 0.5, animations: {() -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        // 还原视图位置
//        var frame = self.view.frame
//        frame.origin.y = 0
//        self.view.frame = frame
        courseViewTopConstraint.constant = 60
        UIView.animate(withDuration: 0.5, animations: {() -> Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func finishInput(_ textArea: UIView) {
        
        // 隐藏阴影
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.1)
        shadow.alpha = 0
        UIView.commitAnimations()
        
        textArea.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        finishInput(textField)
        return true
    }
    
    // 用于比较两个任务先后次序
    func endTimeOrder(a: AssignmentModel, b: AssignmentModel) ->Bool {
        return a.endTime.compare(b.endTime) == .orderedAscending
    }
    
    @IBAction func addAssignmentButtonDown(_ sender: UIBarButtonItem) {
        
        // 检查是否选择了课程
        if courseVC?.course == "" {
            let alertController = UIAlertController(title: "提示", message: "未选择课程！", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        // 检查结束时间是否有效
        else if !timeVC.finish {
            let alertController = UIAlertController(title: "提示", message: "未选择结束时间！", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if timeVC.beginTime.compare(timeVC.endTime) != ComparisonResult.orderedAscending {
            let alertController = UIAlertController(title: "提示", message: "任务结束时间不能晚于开始时间！", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        // 检查是否输入了作业内容
        else if contentField.text == "" {
            let alertController = UIAlertController(title: "提示", message: "未输入作业内容！", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "确定", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        // 信息完整
        else {
            
            // 将信息保存到assignmentList中
            let course = courseVC.course
            let content = contentField.text!
            let note = noteText.text!
            let beginTime = timeVC.beginTime!
            let endTime = timeVC.endTime!
            assignmentList.append(AssignmentModel(in: course, todo: content, note: note, from: beginTime, to: endTime))
            
            // 插入列表后按结束时间重新排序
            assignmentList.sort(by: endTimeOrder)
            
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
}
