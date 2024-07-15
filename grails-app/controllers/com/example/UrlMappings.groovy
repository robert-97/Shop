package com.example

class UrlMappings {
    static mappings = {
        "/$controller/$action?/$id?(.$format)?" {
            constraints {
            }
        }
        "/index"(view:"/index")
        "/"(view: "index")
        "500"(view: '/error')
        "404"(view: '/notFound')

        "/items"(controller: "item", action: "list")
        "/item/create"(controller: "item", action: "create")
        "/item/save"(controller: "item", action: "save")
        "/item/edit/$id"(controller: "item", action: "edit")
        "/item/update/$id"(controller: "item", action: "update")
        "/item/delete/$id"(controller: "item", action: "delete")



        "/warehouses"(controller: 'warehouse', action: 'list')
        "/warehouse/create"(controller: 'warehouse', action: 'create')
        "/warehouse/save"(controller: 'warehouse', action: 'save')
        "/warehouse/edit/$id"(controller: 'warehouse', action: 'edit')
        "/warehouse/update/$id"(controller: 'warehouse', action: 'update')
        "/warehouse/delete/$id"(controller: 'warehouse', action: 'delete')


        "/shops"(controller: 'shop', action: 'list')
        "/shop/create"(controller: 'shop', action: 'create')
        "/shop/save"(controller: 'shop', action: 'save')
        "/shop/edit/$id"(controller: 'shop', action: 'edit')
        "/shop/update"(controller: 'shop', action: 'update')
        "/shop/delete/$id"(controller: 'shop', action: 'delete')


    }
}
