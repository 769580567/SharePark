//
//  informationViewController.swift
//  IPMS
//
//  Created by air on 2017/3/21.
//  Copyright © 2017年 com.Chenziyang. All rights reserved.
//

import UIKit
import SDWebImage
import AVOSCloud

class InformationViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    lazy var user: AVUser = {
        let user = AVUser.current()
        return user!
    }()

    //界面控件的初始化
    lazy var coverImage:UIImageView = {
        let coverImage = UIImageView()
        coverImage.layer.cornerRadius = 25
        coverImage.layer.masksToBounds = true
        
        if let avatarAddress = self.user["avatarImage"] as? String {
            let avatatUrl = URL(string: avatarAddress)
            coverImage.sd_setImage(with: avatatUrl, placeholderImage: UIImage(named: "Avatar"))
        }
        else {
            coverImage.image = UIImage(named: "Avatar")
        }
        
        return coverImage
    }()
    lazy var coverControl:UIControl = {
       let control = UIControl()
        control.addSubview(self.coverImage)
        return control
    }()
    lazy var tableView:UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
        return tableView
    }()
    lazy var imagePicker:UIImagePickerController = {
       let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        return picker
    }()
    
    
    let dataArray = ["我的名字:","我的车位:","我的余额:","我的电话:","我的邮箱:","修改密码"]
    var dataArray2 = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "用户信息"
        self.view.backgroundColor = UIColor(red: 242/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"icon_back"), style: .plain, target: self, action: #selector(InformationViewController.back(sender:)))
        
        setupInterface()
        coverControl.addTarget(self, action: #selector(InformationViewController.changeAvatarAction(sender:)), for: UIControlEvents.touchUpInside)
        
        
        
        self.tableView.separatorStyle = .none
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = true
        
        dataArray2.append(self.user.username!)
        dataArray2.append("\(self.user["carNumber"]!)")
        dataArray2.append("\(self.user["balance"]!) 元")
        dataArray2.append(self.user.mobilePhoneNumber!)
        dataArray2.append(self.user.email!)
        
        freshData()
    }
    
    func freshData(){
        dataArray2[0] = self.user.username!
        dataArray2[1] = "\(self.user["carNumber"]!)"
        dataArray2[2] = "\(self.user["balance"]!) 元"
        dataArray2[3] = self.user.mobilePhoneNumber!
        dataArray2[4] = self.user.email!
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //配置tableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? detailTableView_Cell
        
        cell?.firstLabel.text = dataArray[indexPath.row]
        if indexPath.row == 5{
            cell?.firstLabel.textAlignment = .center
            cell?.firstLabel.snp.remakeConstraints({ (make) in
                make.top.equalTo(cell!.contentView).offset(5)
                make.leading.equalTo(cell!.contentView).offset(15)
                make.trailing.equalTo(cell!.contentView).offset(-15)
            })
            cell?.secondLabel.snp.remakeConstraints({ (make) in
                make.leading.top.bottom.equalTo(cell!.contentView)
                make.width.equalTo(0)
            })
        }else {
//            cell?.secondLabel.text = "content"
            cell?.secondLabel.text = dataArray2[indexPath.row]
        }
        
        cell?.backgroundColor = UIColor.clear
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            
        }else {
            let vc = ChangeInformationViewController()
            vc.indexPath = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    //界面控件布局设置
    func setupInterface() {
//        self.view.addSubview(coverImage)
        self.view.addSubview(coverControl)
        self.view.addSubview(tableView)
        
        setupViewsConstraints()
    }
    func setupViewsConstraints() {
        coverControl.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(85)
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(SCREEN_WIDTH/2 - 16)
        }
        coverImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.height.equalTo(SCREEN_WIDTH/2 - 16)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(coverImage.snp.bottom).offset(15)
            make.leading.equalTo(self.view).offset(15)
            make.trailing.bottom.equalTo(self.view).offset(-15)
        }
        self.tableView.isScrollEnabled = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(detailTableView_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        
    }
    func back(sender:UIBarButtonItem){
        self.navigationController?.popViewController(animated: true)
    }
    
    func showImagePicker(){
        let actionSheet = UIAlertController(title: "更换头像", message: nil, preferredStyle: .actionSheet)
        let takePhoneAction = UIAlertAction(title: "拍张上传", style: .default) { (action) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let chooseFromAlbumAction = UIAlertAction(title: "从相册选择", style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        actionSheet.addAction(takePhoneAction)
        actionSheet.addAction(chooseFromAlbumAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func changeAvatarAction(sender:UIControl){
//        debugLog()
        showImagePicker()
    }

    
}

extension InformationViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.coverImage.image = pickImage
            
            let compressImage = pickImage.compressedImage()
            let data = UIImagePNGRepresentation(compressImage)
            
            let file = AVFile(name: "avatar.png", data: data!)
            file.saveInBackground({ (success: Bool, error: Error?) in
                self.user.setObject(file.url!, forKey: "avatarImage")
                self.user.save()
            })
            
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension UIImage{
    func compressedImage() -> UIImage {
        let scaleFactor = max(size.width/300, size.height/300)
        let newSize = CGSize(width: size.width/scaleFactor, height: size.height/scaleFactor)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 1)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        
        let compressdImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsPopContext()
        
        return compressdImage!
        
        
        
        
    }
}
