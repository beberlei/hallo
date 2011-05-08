#     Hallo - a rich text editing jQuery UI widget
#     (c) 2011 Henri Bergius, IKS Consortium
#     Hallo may be freely distributed under the MIT license
((jQuery) ->
    jQuery.widget "IKS.hallolinkimg",
        options:
            editable: null
            toolbar: null
            uuid: ""
            link: true
            image: true
            dialogOpts:
                autoOpen: false
                width: 540
                height: 120
                title: "Enter Link"
                modal: true

        _create: ->
            widget = this

            dialogId = "#{@options.uuid}-dialog"
            dialog = jQuery "<div id=\"#{dialogId}\"><form action=\"#\" method=\"post\"><input class=\"url\" type=\"text\" name=\"url\" size=\"40\" value=\"http://\" /><input type=\"submit\" value=\"Insert\" /></form></div>"
            dialogSubmitCb = () ->
                link = $(this).find(".url").val()
                widget.options.editable.execute "createLink", link
                dialog.dialog('close')
                return false
            dialog.find("form").submit dialogSubmitCb

            buttonset = jQuery "<span></span>"
            buttonize = (type, label) =>
                id = "#{@options.uuid}-#{type}"
                buttonset.append jQuery("<input id=\"#{id}\" type=\"checkbox\" /><label for=\"#{id}\">#{label}</label>").button()
                button = jQuery "##{id}", buttonset
                button.bind "change", (event) ->
                    dialog.dialog('open')

            if (@options.link)
                buttonize "Link", "A"
            if (@options.image)
                buttonize "Unordered", "UL"

            if (@options.link && @options.image)
                buttonset.buttonset()
                @options.toolbar.append buttonset
                dialog.dialog(@options.dialogOpts)

        _init: ->

)(jQuery)