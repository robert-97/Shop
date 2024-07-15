package com.example

import grails.gorm.transactions.Transactional

@Transactional
class ShopService {

    def sendItemToWarehouse(Long shopId, Long itemId, Long warehouseId, Integer itemCount) {
        Shop shop = Shop.get(shopId)
        Warehouse warehouse = Warehouse.get(warehouseId)
        Item item = Item.get(itemId)

        if (!shop || !warehouse || !item) {
            throw new IllegalArgumentException("Shop, Warehouse, or Item not found")
        }


        ShopItem shopItem = ShopItem.findByShopAndItem(shop, item)
        if (!shopItem || shopItem.itemCount < itemCount) {
            throw new IllegalArgumentException("Not enough items in the shop")

        }
        shopItem.itemCount -= itemCount
        if (shopItem.itemCount < 0) {

        }
        if (shopItem.itemCount == 0) {
            shopItem.delete(flush: true)
        } else {
            if (!shopItem.save(flush: true)) {
                throw new RuntimeException("Failed to update ShopItem: ${shopItem.errors}")
            }
        }

        WarehouseItem warehouseItem = WarehouseItem.findByWarehouseAndItem(warehouse, item)
        if (warehouseItem) {
            warehouseItem.itemCount += itemCount
            if (!warehouseItem.save(flush: true)) {
                throw new RuntimeException("Failed to update WarehouseItem: ${warehouseItem.errors}")
            }
        } else {
            warehouseItem = new WarehouseItem(warehouse: warehouse, item: item, itemCount: itemCount)
            if (!warehouseItem.save(flush: true)) {
                throw new RuntimeException("Failed to create WarehouseItem: ${warehouseItem.errors}")
            }
        }
    }

    def removeItemFromShop(Long shopId, Long itemId) {
        Shop shop = Shop.get(shopId)
        Item item = Item.get(itemId)

        if (!shop || !item) {
            throw new IllegalArgumentException("Shop or Item not found")
        }

        ShopItem shopItem = ShopItem.findByShopAndItem(shop, item)

        if (shopItem) {
            shopItem.delete(flush: true)
        } else {
            throw new RuntimeException("ShopItem not found for this shop and item")
        }
    }

    def checkAndReturnExpiredItems() {
        def currentDate = new Date()
        def expiredItems = ShopItem.createCriteria().list {
            item {
                lt("deadline", currentDate)
            }
        }

        expiredItems.each { shopItem ->

            returnItemToWarehouse(shopItem)
        }
    }

    private void returnItemToWarehouse(ShopItem shopItem) {

        WarehouseItem warehouseItem = WarehouseItem.findByWarehouseAndItem(shopItem.warehouse, shopItem.item)

        if (warehouseItem) {
            warehouseItem.itemCount += shopItem.itemCount
            warehouseItem.save(flush: true)
        } else {

            warehouseItem = new WarehouseItem(warehouse: shopItem.warehouse, item: shopItem.item, itemCount: shopItem.itemCount)
            warehouseItem.save(flush: true)
        }

        shopItem.delete(flush: true)
    }

    def sellItem(Shop shop, Item item, Integer itemCount) {
        if (!shop || !item) {
            flash.message = "Shop or Item not found"
            redirect(action: "list")
            return
        }
        ShopItem shopItem = ShopItem.findByShopAndItem(shop, item)
        if (!shopItem || shopItem.itemCount < itemCount) {
            flash.message = "Not enough items available in the shop"
            redirect(action: "list")
            return
        }
        shopItem.itemCount -= itemCount
        if (shopItem.itemCount == 0) {
            shopItem.delete(flush: true)
        } else {
            shopItem.save(flush: true)
        }
    }
}