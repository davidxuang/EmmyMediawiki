---@meta

---The SVG library provides a way to create SVG images rendered as `<img>` elements in HTML. SVGs are rendered in [secure animated mode](https://svgwg.org/specs/integration/#secure-animated-mode). This means that scripts and external resources are not rendered but declarative animations such as SMIL or CSS `@keyframe` are allowed as long as they don't need user interaction.

---CSS from the surrounding page do not affect the SVG elements inside the file so you cannot use CSS variables like --color-base in your svg. You can however use [prefers-color-scheme](https://developer.mozilla.org/Web/CSS/@media/prefers-color-scheme) @media queries or the [`light-dark()`](https://developer.mozilla.org/Web/CSS/color_value/light-dark) CSS function to make the SVG night mode compatible

---For documentation on how SVG works, please see [MDN](https://developer.mozilla.org/Web/SVG/Tutorials/SVG_from_scratch).
mw.svg = {
    ---Initializes a new SVG image object
    ---@return Svg
    new = function () end
}

---@class Svg
local svg = {}

---Sets the inner content of the `<svg>` tag.
---@param ... string
---@return Svg self
function svg:setContent ( ... ) end

---Sets an attribute of the `<svg>` tag.
---@param name string
---@param value string
---@return Svg self
function svg:setAttribute ( name, value ) end

---Sets an attribute of the resulting `<img>` tag.
---@param name 'width'|'height'|'class'|'id'|'alt'|'title'|'style'
---@param value string
---@return Svg self
function svg:setImgAttribute ( name, value ) end

---Generates the final `<img>` tag.
---@return string img A strip marker.
function svg:toImage () end
