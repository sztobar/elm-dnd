Elm.Native = Elm.Native || {};
Elm.Native.HtmlDrag = {};
Elm.Native.HtmlDrag.make = function(elm) {

  elm.Native = elm.Native || {};
  elm.Native.HtmlDrag = elm.Native.HtmlDrag || {};

  if (elm.Native.HtmlDrag.values) {
    return elm.Native.HtmlDrag.values;
  }

  var VirtualDom = Elm.Native.VirtualDom.make(elm);
  var property = VirtualDom.property;

  return elm.Native.HtmlDrag.values = {
    dragOverPrevent: A2(property, 'ondragover', function(event) {
      event.preventDefault();
      return false;
    })
  };
};
