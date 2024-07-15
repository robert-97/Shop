package com.example

import grails.gorm.transactions.Transactional


class ItemController {
    def list() {
        [itemList: Item.list()]
    }
    def index() {
    }

    def create() {
        [item: new Item()]
    }

    @Transactional
    def save() {
        def item = new Item(params)
        if (!params.hasDeadline || params.deadline.trim().isEmpty()) {
            item.deadline = null
        }
        if (item.save(flush: true)) {
            redirect(action: "list")
        } else {
            render(view: "create", model: [item: item])
        }
    }

    def edit(Long id) {
        respond Item.get(id)
    }

    @Transactional
    def update(Long id) {
        def item = Item.get(id)
        if (!item) {
            flash.message = "Item not found"
            redirect(action: "list")
            return
        }
        if (!params.hasDeadline || params.deadline.trim().isEmpty()) {
            params.deadline = null
        }
        item.properties = params
        if (item.save(flush: true)) {
            redirect(action: "list")
        } else {
            render(view: "edit", model: [item: item])
        }
    }



    @Transactional
    def delete(Long id) {
        try {
            Item item = Item.get(id)

            if (!item) {
                flash.message = "Item not found"
                redirect(action: "list")
                return
            }

            boolean isUsedInWarehouse = WarehouseItem.countByItem(item) > 0
            boolean isUsedInShop = ShopItem.countByItem(item) > 0

            if (isUsedInWarehouse || isUsedInShop) {
                flash.message = "Item cannot be deleted as it is used in a warehouse or shop"
                redirect(action: "list", id: id)
                return
            }

            item.delete(flush: true)
            flash.message = "Item deleted successfully"
            redirect(action: "list")
        } catch (Exception e) {
            flash.message = "An error occurred while deleting the item: ${e.message}"
            redirect(action: "list", id: id)
        }
    }
}