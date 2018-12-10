import UIKit
/**
 * 父类中包含:
 * id:String
 * name:String
 */
import ObjectMapper

/**
 * 数据解析Model
 */
class BaseStudentsDataModel: BaseModel {
    var data:BaseStudentsModel = BaseStudentsModel()
    override func mapping(map: Map) {
        code    <- map["code"]
        msg     <- map["msg"]
        data    <- map["data"]
    }
}

/**
 * 学生Model
 * @param id : 当前学生ID
 * @param name : 当前学生名
 * @param currentIndex : 当前学生索引
 * @param students : 学生列表
 */
class BaseStudentsModel:BaseModel{
    var students:Array<BaseStudentInfoModel> = []
    private var _currentIndex:Int = -1
    var currentIndex:Int{
        get{
            if students.count <= 0 {
                return -1
            }
            else{
                for i in 0..<students.count{
                    if self.id == students[i].id{
                        return i
                    }
                }
                return -1
            }
        }
        set{
            _currentIndex = newValue
            if _currentIndex >= 0 && _currentIndex < students.count{
                id = students[currentIndex].id
                name = students[currentIndex].name
            }
        }
    }
    
    override func mapping(map: Map) {
        id      <- (map["defaultId"],transfromOfCustomFunction())
        name    <- map["defaultName"]
        students    <- map["list"]
        
    }
    
}



class BaseStudentInfoModel: BaseModel {
    var studentNo:String = ""       //学号
    var portrait:String = ""
    var isSelected:Bool = false     //是否被选中
    var schId:String = ""     //学校id
    
    override init() {
        super.init()
    }
    
    init(name:String, no:String){
        super.init()
        studentNo = no
        self.name = name
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    

    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id    <- (map["stuId"],transfromOfCustomFunction())
        name        <- map["stuName"]
        studentNo   <- map["stuNo"]
        portrait    <- map["iconUrl"]
        schId    <- (map["schId"],transfromOfCustomFunction())
        
        
    }

    
    


    
    func toNSObject() -> ObjcBaseStudentInfoModel{
        let newObj = ObjcBaseStudentInfoModel()
        newObj.id           = self.id
        newObj.name         = self.name
        newObj.studentNo    = self.studentNo
        newObj.isSelected   = self.isSelected
        newObj.portrait     = self.portrait
        newObj.schId     = self.schId
        
        return newObj
    }
}

class ObjcBaseStudentInfoModel: NSObject{
    var id = ""
    var name = ""
    var studentNo:String = ""       //学号
    var isSelected:Bool = false     //是否被选中
    var portrait:String = ""
    var schId:String = ""     //学校id
    
    func toAnyObject() ->BaseStudentInfoModel{
        let model = BaseStudentInfoModel()
        model.id            = self.id
        model.name          = self.name
        model.studentNo     = self.studentNo
        model.isSelected    = self.isSelected
        model.portrait      = self.portrait
        model.schId      = self.schId
        return model
    }
    
}
