package com.example

import grails.gorm.transactions.Transactional


class WarehouseController {

    WarehouseService warehouseService

    def list() {
        render(view: 'list', model: [warehouses: Warehouse.list()])
    }

    def create() {
        render(view: 'create', model: [warehouse: new Warehouse()])
    }

    @Transactional
    def save() {
        def warehouse = new Warehouse(params)
        if (warehouse.save(flush: true)) {
            flash.message = "Warehouse created successfully"
            redirect(action: "edit", id: warehouse.id)
        } else {
            render(view: 'create', model: [warehouse: warehouse])
        }
    }

    @Transactional
    def edit(Long id) {
        def warehouse = Warehouse.get(id)
        if (!warehouse) {
            flash.message = "Warehouse not found"
            redirect(action: "list")
            return
        }
        [warehouse: warehouse, itemList: Item.list(), shopList : Shop.list()]
    }

    @Transactional
    def update(Long id) {
        def warehouse = Warehouse.get(id)
        if (!warehouse) {
            flash.message = "Warehouse not found"
            redirect(action: "list")
            return
        }
        warehouse.properties = params
        if (warehouse.save(flush: true)) {
            flash.message = "Warehouse updated successfully"
            redirect(action: "edit", id: warehouse.id)
        } else {
            render(view: 'edit', model: [warehouse: warehouse])
        }
    }

    @Transactional
    def delete(Long id) {
        def warehouse = Warehouse.get(id)
        if (warehouse) {
            warehouse.delete(flush: true)
            flash.message = "Warehouse deleted successfully"
        } else {
            flash.message = "Warehouse not found"
        }
        redirect(action: "list")
    }

    @Transactional
    def addItem() {
        try {
            warehouseService.addItemToWarehouse(params.warehouseId as Long, params.item.id as Long, params.itemCount as int)
            redirect(action: "edit", id: params.warehouseId)
        } catch (Exception e) {
            flash.message = e.message
            redirect(action: "edit", id: params.warehouseId)
        }
    }


    @Transactional
    def removeItem() {
        try {
            Long  warehouseId = params.warehouseId as Long
            Long itemId = params.itemId as Long

            warehouseService.deleteWarehouseItem(warehouseId, itemId)
            flash.message = "Item removed successfully."
        } catch (Exception e) {
            flash.message = e.message
        }
        redirect(action: "edit", id: params.warehouseId)
    }

    @Transactional
    def deliverItem() {
        try {
            warehouseService.deliverItemToShop(params.warehouseId as Long, params.shopId as Long, params.itemId as Long, params.itemCount as int)
            flash.message = "Item delivered successfully"
            redirect(action: "edit", id: params.warehouseId)
        } catch (Exception e) {
            flash.message = e.message
            redirect(action: "edit", id: params.warehouseId)
        }
    }
}

