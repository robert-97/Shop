package com.example


class ShopItem {
    Integer id
    Shop shop
    Item item
    Warehouse warehouse
    Integer itemCount

    static constraints = {
        shop nullable: false
        item nullable: false
        warehouse nullable: false
        itemCount nullable: false, min: 0
    }

    static mapping = {
        table 'shop_item'
        id generator: 'identity'
        version false
    }
}

