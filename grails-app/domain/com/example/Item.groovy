package com.example
import groovy.transform.ToString

@ToString
class Item {
    Integer id
    String code
    String name
    Long price
    Date createdDate
    Date deadline
    boolean hasDeadline

    static transients = ['hasDeadline']

    static constraints = {
        code blank: false, unique: true
        name blank: false, unique: true
        price blank: false
        createdDate blank: false
        deadline blank: true , nullable: true
    }

    static mapping = {
        id generator: 'identity'
        version false
    }

    boolean getHasDeadline() {
        return this.deadline != null
    }

    static hasMany = [warehouseItems: WarehouseItem]
}