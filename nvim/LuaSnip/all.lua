-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua

-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
--local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
--local f = ls.function_node
--local d = ls.dynamic_node
--local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
--local rep = require("luasnip.extras").rep

local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end


return {
-- A snippet that expands the trigger "hi" into the string "Hello, world!".
  s({ trig = "hi" },
  {
    t("Hello, world!")
  }),

  -- To return multiple snippets, use one `return` statement per snippet file
  -- and return a table of Lua snippets.
  s({ trig = "foo" },
  {
    t("Another snippet.")
  }),

  s({trig = "trigger"},
  {
    t({"After expanding, the cursor is here ->"}), i(1),
    t({"", "After jumping forward once, cursor is here ->"}), i(2),
    t({"", "After jumping once more, the snippet is exited there ->"}), i(0),
  }),

s({trig = "ff", snippetType="autosnippet"},
  fmta(
    "\\frac{<>}{<>}",
    {i(1),i(2),}
  ),
  {condition = in_mathzone}  -- `condition` option passed in the snippet `opts` table 
),


s({trig = "ga", snippetType="autosnippet"},
{t("\\alpha ")},
{condition = in_mathzone}),

s({trig = "gb", snippetType="autosnippet"},
{t("\\beta ")},
{condition = in_mathzone}),

s({trig = "gg", snippetType="autosnippet"},
{t("\\gamma ")},
{condition = in_mathzone}),

s({trig = "gd", snippetType="autosnippet"},
{t("\\delta ")},
{condition = in_mathzone}),

s({trig = "GO", snippetType="autosnippet"},
{t("\\Omega ")},
{condition = in_mathzone}),

s({trig = "GG", snippetType="autosnippet"},
{t("\\Gamma ")},
{condition = in_mathzone}),

s({trig = "GD", snippetType="autosnippet"},
{t("\\Delta ")},
{condition = in_mathzone}),

s({trig = "pi", snippetType="autosnippet"},
{t("\\pi ")},
{condition = in_mathzone}),

}

