package com.example

class Warehouse {

    Integer id
    String code
    String name
    String address

    static hasMany = [warehouseItems: WarehouseItem]

    static constraints = {
        code(blank: false, maxSize: 100, unique: true)
        name(blank: false, maxSize: 100, unique: true)
        address(blank: false, maxSize: 255)
    }

    static mapping = {
        id generator: 'identity'
        version false
    }

}