//: Playground - noun: a place where people can play

import UIKit

// 下标脚本(Subscripts)

/*
    下标脚本 可以定义在类(Class)、结构体(structure)和枚举(enumeration)这些目标中,可以认为是访问 集合(collection),列表(list)或序列(sequence的快捷方式,使用下标脚本的索引设置和获取值,不需要 再调用实例的特定的赋值和访问方法。举例来说,用下标脚本访问一个数组(Array)实例中的元素可以这样写 meArray[index] ,访问字典(Dictionary)实例中的元素可以这样写 someDictionary[key] 。
    对于同一个目标可以定义多个下标脚本,通过索引值类型的不同来进行重载,下标脚本不限于单个纬度,你可以定义多个入参的下标脚本满足自定义类型的需求。

*/



// 语法
/*
    下标脚本允许你通过在实例后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值。
    语法类似于实例方法和计算型属性的混合。
    与定义实例方法类似,定义下标脚本使用 subscript 关键字,显式声明入参(一个 或多个)和返回类型。
    与实例方法不同的是下标脚本可以设定为读写或只读。
    这种方式又有点像计算型属性的getter和setter:
*/
class SubScriptClass {
    
    var numbers = [1, 2, 3, 4, 5]
    var dictionary = ["one" : 1, "two" : 2, "three" : 3, "four" : 4]
    
    subscript(index: Int) -> Int? {
        get {
            // 返回与传入参数匹配的Int类型的值
            return index < numbers.count ? numbers[index] : nil
        }
        set {
            // 执行赋值操作
            if let value = newValue where index < numbers.count {
                numbers[index] = value
            }
        }
        
    }
    // 与只读计算型属性一样,可以直接将原本应该写在 get 代码块中的代码写在 subscript 中
    subscript(key: String) -> Int? {
        return dictionary[key]
    }
}

let testClass = SubScriptClass()
let number = testClass["one"] // 1
let noNum = testClass["five"] // nil
if number != nil {
    let arrNum = testClass[number!]
}

if let num = noNum {
    print("arr number = \(testClass[num])")
} else {
    print("noNum is nil")
}


let arrNum1 = testClass[3] // 4
let arrNum2 = testClass[5] // nil

testClass[4] = 8
print("testClass numbers = \(testClass.numbers)")
testClass[5] = 9
print("testClass numbers = \(testClass.numbers)")



//  下标脚本用法
/*
    根据使用场景不同下标脚本也具有不同的含义。
    通常下标脚本是用来访问集合(collection),列表(list)或 序列(sequence)中元素的快捷方式。
    你可以在你自己特定的类或结构体中自由的实现下标脚本来提供合适的功能。
*/

// 例如,Swift 的字典(Dictionary)实现了通过下标脚本来对其实例中存放的值进行存取操作。在下标脚本中使 用和字典索引相同类型的值,并且把一个字典值类型的值赋值给这个下标脚本来为字典设值:

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2


/*
    Swift 中字典的附属脚本实现中,在 get 部分返回值是 Int? ,上例中的 numberOfLegs 字典通过附属脚本返回 的是一个 Int? 或者说“可选的int”,不是每个字典的索引都能得到一个整型值,对于没有设过值的索引的访 问返回的结果就是 nil ;同样想要从字典实例中删除某个索引下的值也只需要给这个索引赋值为 nil 即可。
*/


// 下标脚本选项
/*
    下标脚本允许任意数量的入参索引,并且每个入参类型也没有限制。
    下标脚本的返回值也可以是任何类型。
    **下标 脚本可以使用变量参数和可变参数,但使用写入读出(in-out)参数或给参数设置默认值都是不允许的。

    一个类或结构体可以根据自身需要提供多个下标脚本实现,在定义下标脚本时通过入参的类型进行区分,使用下标脚本时会自动匹配合适的下标脚本实现运行,这就是下标脚本的重载。
*/


// 一个下标脚本入参是最常见的情况,但只要有合适的场景也可以定义多个下标脚本入参。如下例定义了一个 x 结构体,将呈现一个 Double 类型的二维矩阵。 Matrix 结构体的下标脚本需要两个整型参数:
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(_rows: Int, _columns: Int){
        rows = _rows
        columns = _columns
        grid = Array(count: _rows * _columns, repeatedValue: 0.0)
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValidForRow(row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set(value) {
            assert(indexIsValidForRow(row, column: column), "index out of range")
            grid[(row * columns) + column] = value
        }
    }

}

var matrix = Matrix(_rows: 2, _columns: 3)
print("grid = \(matrix.grid)")
matrix[0, 1] = 3.14
print("grid = \(matrix.grid)")
matrix[1, 0] = 2.5
print("grid = \(matrix.grid)")

// print("grid = \(matrix[3, 5])") // 触发断言， "index out of range"


print("matrix[1, 2] = \(matrix[1, 2])")

// print("matrix[2, 2] = \(matrix[2, 2])") // 触发断言， "index out of range"



























