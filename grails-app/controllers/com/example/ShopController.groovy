package com.example

import grails.gorm.transactions.Transactional


class ShopController {

    ShopService shopService

    def list() {
        render(view: 'list', model: [shopList: Shop.list()])
    }



    @Transactional
    def create() {
    }

    @Transactional
    def save() {
        def shop = new Shop(params)
        if (shop.save(flush: true)) {
            flash.message = "Shop created successfully"
            redirect(action: "list")
        } else {
            render(view: "create", model: [shop: shop])
        }
    }

    @Transactional
    def edit(Long id) {
        def shop = Shop.get(id)
        if (!shop) {
            flash.message = "Shop not found"
            redirect(action: "list")
            return
        }
        [shop: shop, itemList: ShopItem.list(), "warehouseList": Warehouse.list()]
    }

    @Transactional
    def update(Long id) {
        def shop = Shop.get(id)
        if (!shop) {
            flash.message = "Shop not found"
            redirect(action: "list")
            return
        }

        shop.properties = params

        if (shop.save(flush: true)) {
            flash.message = "Shop updated successfully"
            redirect(action: "list")
        } else {
            render(view: "edit", model: [shop: shop])
        }
    }

    @Transactional
    def delete(Long id) {
        def shop = Shop.get(id)
        if (shop) {
            shop.delete(flush: true)
            flash.message = "Shop deleted successfully"
        } else {
            flash.message = "Shop not found"
        }
        redirect(action: "list")
    }

    @Transactional
    def sendItemToWarehouse() {
        try{
            Long shopId = params.shopId as Long
            Long itemId = params.itemId  as Long
            Long warehouseId = params.warehouseId as Long
            Integer itemCount = params.itemCount  as Integer

            shopService.sendItemToWarehouse(shopId,itemId,warehouseId,itemCount)

        } catch (Exception e) {
            flash.message = e.message
        }
        redirect(action: "edit", id: params.shopId)
    }

    @Transactional
    def removeItem() {
        try {
            Long shopId = params.shopId as Long
            Long itemId = params.itemId as Long

            shopService.removeItemFromShop(shopId, itemId)
            flash.message = "Item removed successfully."
        } catch (Exception e) {
            flash.message = e.message
        }
        redirect(action: "edit", id: params.shopId)
    }
    @Transactional
    def sellItem(Long shopId, Long itemId, Integer itemCount) {
        Shop shop = Shop.get(shopId)
        Item item = Item.get(itemId)
        shopService.sellItem(shop, item,itemCount)
        flash.message = "Successfully sold ${item.name} (x${itemCount})"
        redirect(action: "edit", id: params.shopId)
    }
}