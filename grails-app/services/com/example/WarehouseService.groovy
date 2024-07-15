package com.example

import javax.transaction.Transactional

@Transactional
class WarehouseService {

    def addItemToWarehouse(Long warehouseId, Long itemId, Integer itemCount) {
        Warehouse warehouse = Warehouse.get(warehouseId)
        Item item = Item.get(itemId)

        if (!warehouse || !item) {
            throw new IllegalArgumentException("Warehouse or Item not found")
        }

        WarehouseItem warehouseItem = WarehouseItem.findByWarehouseAndItem(warehouse, item)

        if (warehouseItem) {
            warehouseItem.itemCount += itemCount
        } else {
            warehouseItem = new WarehouseItem(warehouse: warehouse, item: item, itemCount: itemCount)
        }

        if (!warehouseItem.save(flush: true)) {
            throw new RuntimeException("Failed to add item to warehouse: ${warehouseItem.errors}")
        }
    }



    def deleteWarehouseItem(Long warehouseId, Long itemId) {
        Warehouse warehouse = Warehouse.get(warehouseId)
        Item item = Item.get(itemId)

        if (!warehouse || !item) {
            throw new IllegalArgumentException("Warehouse or Item not found")
        }
        WarehouseItem warehouseItem = WarehouseItem.findByWarehouseAndItem(warehouse, item)

        if (warehouseItem) {
            warehouseItem.delete(flush: true)
        } else {
            throw new RuntimeException("WarehouseItem not found for this warehouse and item")
        }
    }

    def deliverItemToShop(Long warehouseId, Long shopId, Long itemId, Integer itemCount) {
        Warehouse warehouse = Warehouse.get(warehouseId)
        Shop shop = Shop.get(shopId)
        Item item = Item.get(itemId)

        if (!warehouse || !shop || !item) {
            throw new IllegalArgumentException("Warehouse, Shop, or Item not found")
        }

        WarehouseItem warehouseItem = WarehouseItem.findByWarehouseAndItem(warehouse, item)
        if (!warehouseItem || warehouseItem.itemCount < itemCount) {
            throw new IllegalArgumentException("Not enough items in the warehouse")
        }

        warehouseItem.itemCount -= itemCount
        if (warehouseItem.itemCount == 0) {
            warehouseItem.delete(flush: true)
        } else {
            warehouseItem.save(flush: true)
        }

        ShopItem shopItem = ShopItem.findByShopAndItemAndWarehouse(shop, item, warehouse)
        if (shopItem) {
            shopItem.itemCount += itemCount
        } else {
            shopItem = new ShopItem(shop: shop, item: item, warehouse: warehouse, itemCount: itemCount)
        }

        if (!shopItem.save(flush: true)) {
            throw new RuntimeException("Failed to add item to shop: ${shopItem.errors}")
        }
    }
}