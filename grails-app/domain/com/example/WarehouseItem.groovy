package com.example

class WarehouseItem {
    Integer id
    Warehouse warehouse
    Item item
    Integer itemCount

    static constraints = {
        warehouse(nullable: false)
        item(nullable: false)
        itemCount(min: 0)
    }


    static mapping = {
        table 'warehouse_item'
        id generator: 'identity'
        version false
    }

}