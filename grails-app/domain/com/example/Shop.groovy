package com.example

class Shop {

    String name
    String code
    String address
    static hasMany = [shopItems: ShopItem]

    static constraints = {
        name nullable: false, blank: false
        code nullable: false, unique: true
        address nullable: false, blank: false
    }

    static mapping = {
        table 'shop'
        version false
    }
}
