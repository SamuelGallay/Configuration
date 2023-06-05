-- Place this in ${HOME}/.config/nvim/LuaSnip/all.lua

-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
--local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
--local d = ls.dynamic_node
--local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

<<<<<<< HEAD
=======
-- Magic code from https://github.com/nvim-treesitter/nvim-treesitter/issues/1184
local has_treesitter, ts = pcall(require, 'vim.treesitter')
local _, _ = pcall(require, 'vim.treesitter.query')

local MATH_NODES = {
    displayed_equation = true,
    inline_formula = true,
    math_environment = true,
}

local COMMENT = {
    ['comment'] = true,
    ['line_comment'] = true,
    ['block_comment'] = true,
    ['comment_environment'] = true,
}

local function get_node_at_cursor()
    local buf = vim.api.nvim_get_current_buf()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1
    col = col - 1

    local ok, parser = pcall(ts.get_parser, buf, 'latex')
    if not ok or not parser then return end

    local root_tree = parser:parse()[1]
    local root = root_tree and root_tree:root()

    if not root then
        return
    end

    return root:named_descendant_for_range(row, col, row, col)
end

local function in_comment()
    if has_treesitter then
        local node = get_node_at_cursor()
        while node do
            if COMMENT[node:type()] then
                return true
            end
            node = node:parent()
        end
        return false
    end
end

local function in_mathzone()
    if has_treesitter then
        local node = get_node_at_cursor()
        while node do
            if node:type() == 'text_mode' then
                return false
            elseif MATH_NODES[node:type()] then
                return true
            end
            node = node:parent()
        end
        return false
    end
end
-- End of magic code

--[[ Old version with VimTeX
>>>>>>> 68f0b94 (LuaSnip, etc.)
local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
<<<<<<< HEAD

=======
]]
>>>>>>> 68f0b94 (LuaSnip, etc.)

local simple_table = {
  ["al"] = "alpha",
  ["be"] = "beta",
  ["ga"] = "gamma",
  ["de"] = "delta",
  ["ep"] = "varepsilon",
  ["ze"] = "zeta",
  ["et"] = "eta",
  ["th"] = "theta",
  ["io"] = "iota",
  ["ka"] = "kappa",
  ["la"] = "lambda",
  ["mu"] = "mu",
  ["nu"] = "nu",
  ["xi"] = "xi",
  ["pi"] = "pi",
  ["rh"] = "rho",
  ["sig"] = "sigma",
  ["tau"] = "tau",
  ["up"] = "upsilon",
  ["ph"] = "varphi",
  ["kh"] = "chi",
<<<<<<< HEAD
=======
  ["ch"] = "chi",
>>>>>>> 68f0b94 (LuaSnip, etc.)
  ["ps"] = "psi",
  ["om"] = "omega",

  ["neps"] = "epsilon",
  ["nphi"] = "phi",

  ["GA"] = "Gamma",
  ["DE"] = "Delta",
  ["TH"] = "Theta",
  ["LA"] = "Lambda",
  ["XI"] = "Xi",
  ["PI"] = "Pi",
  ["SI"] = "Sigma",
  ["UP"] = "Upsilon",
  ["PH"] = "Phi",
  ["PS"] = "Psi",
  ["OM"] = "Omega",

<<<<<<< HEAD
=======
  ["EE"] = "E",
  ["FF"] = "F",
  ["AA"] = "A",

>>>>>>> 68f0b94 (LuaSnip, etc.)
  ["sin"] = "sin",
  ["cos"] = "cos",
  ["tan"] = "tan",
  ["log"] = "log",
  ["le"] = "le",
  ["ge"] = "ge",
  ["sub"] = "subseteq",
  ["appr"] = "approx",
  ["vee"] = "vee",
  ["wed"] = "wedge",
  ["cup"] = "cup",
  ["cap"] = "cap",
  ["cd"] = "cdot",
  ["neq"] = "neq",
  ["nin"] = "notin",
<<<<<<< HEAD
=======
  ["ni"] = "in",
>>>>>>> 68f0b94 (LuaSnip, etc.)

  ["QQ"] = "Q",
  ["CC"] = "C",
  ["RR"] = "R",
  ["NN"] = "N",
  ["ZZ"] = "Z",

  ["ex"] = "exists",
  ["fa"] = "forall",
  ["iff"] = "iff",
  ["imp"] = "implies",
  ["to"] = "to",
  ["mt"] = "mapsto",
  ["oo"] = "infty",
<<<<<<< HEAD
=======
  ["wt"] = "widetilde",
  ["ii"] = "1",
  ["kn"] = ",|\\,",
  ["qd"] = "quad",
  ["BB"] = "Big",
  ["bb"] = "big",
  ["bl"] = "bigl",
  ["br"] = "bigr",
  ["BL"] = "Bigl",
  ["BR"] = "Bigr",
>>>>>>> 68f0b94 (LuaSnip, etc.)

  ["df"] = "diff",
}

local simple_math_snippets = {}
for key, val in pairs(simple_table) do
   table.insert(simple_math_snippets,
    s(
    {trig = key, snippetType="autosnippet",},
    t("\\"..val.." "),
    {condition = in_mathzone})
  )
end

local other_math_snippets = {
s({trig = "^", snippetType="autosnippet", wordTrig=false, priority=3000},
fmta("^{<>}",{i(1),}),
{condition = in_mathzone }),

s({trig = "_", snippetType="autosnippet", wordTrig=false, priority=3000},
fmta("_{<>}",{i(1),}),
{condition = in_mathzone, wordTrig=false}),

s({trig = "ff", snippetType="autosnippet"},
fmta("\\frac{<>}{<>} ",{i(1),i(2),}),
{condition = in_mathzone}),

s({trig = "nn", snippetType="autosnippet"},
fmta("\\| <> \\|_{<>} ",{i(1),i(2),}),
{condition = in_mathzone}),

s({trig = "ceil", snippetType="autosnippet"},
fmta("\\lceil <> \\rceil ",{i(1),}),
{condition = in_mathzone}),

s({trig = "floor", snippetType="autosnippet"},
fmta("\\lfloor <> \\rfloor ",{i(1),}),
{condition = in_mathzone}),

s({trig = "sc", snippetType="autosnippet"},
fmta("\\langle <>, <> \\rangle ",{i(1), i(2),}),
{condition = in_mathzone}),

s({trig = "set", snippetType="autosnippet"},
fmta("\\{ <>, \\} ",{i(1),}),
{condition = in_mathzone}),

s({trig = "int", snippetType="autosnippet"},
fmta("\\int_{<>}^{<>} <> \\diff <> ",{i(1),i(2),i(3),i(4)}),
{condition = in_mathzone}),

s({trig = "sum", snippetType="autosnippet"},
fmta("\\sum_{<>}^{<>} ",{i(1),i(2),}),
{condition = in_mathzone}),

<<<<<<< HEAD
=======
s({trig = "prod", snippetType="autosnippet"},
fmta("\\prod_{<>}^{<>} ",{i(1),i(2),}),
{condition = in_mathzone}),

>>>>>>> 68f0b94 (LuaSnip, etc.)
s({trig = "sq", snippetType="autosnippet"},
fmta("\\sqrt{<>} ",{i(1),}),
{condition = in_mathzone}),

s({trig = "ee", snippetType="autosnippet"},
fmta("e^{<>} ",{i(1),}),
{condition = in_mathzone}),

<<<<<<< HEAD
=======
s({trig = "tt", snippetType="autosnippet"},
fmta("\\text{<>} ",{i(1),}),
{condition = in_mathzone}),

>>>>>>> 68f0b94 (LuaSnip, etc.)
s({trig = "min", snippetType="autosnippet"},
fmta("\\min_{<>} ",{i(1),}),
{condition = in_mathzone}),

s({trig = "max", snippetType="autosnippet"},
fmta("\\max_{<>} ",{i(1),}),
{condition = in_mathzone}),

s({trig = "inf", snippetType="autosnippet"},
fmta("\\inf_{<>} ",{i(1),}),
{condition = in_mathzone}),

s({trig = "sup", snippetType="autosnippet"},
fmta("\\sup_{<>} ",{i(1),}),
{condition = in_mathzone}),
}


local environments_snippets = {
s({trig="beg", snippetType="autosnippet"},
fmta([[
\begin{<>}
<>
\end{<>}]], {i(1),i(0),rep(1)}),
{condition = line_begin}),

s({trig="bal", snippetType="autosnippet"},
fmta([[
\begin{align*}
<>
\end{align*}]],{i(0)}),
{condition = line_begin}),

s({trig="leq", snippetType="autosnippet"},
fmta([[
\begin{equation}
\label{eq:<>}
<>
\end{equation}]],{i(1), i(0)}),
{condition = line_begin}),

s({trig="sec", snippetType="autosnippet"},
fmta([[
\section{<>}

<>]],{i(1), i(0)}),
{condition = line_begin}),

s({trig="ssec", snippetType="autosnippet"},
fmta([[
\section{<>}

<>]],{i(1), i(0)}),
{condition = line_begin}),
}


local all_snippets = {}
for _, v in pairs(simple_math_snippets) do table.insert(all_snippets, v) end
for _, v in pairs(other_math_snippets) do table.insert(all_snippets, v) end
for _, v in pairs(environments_snippets) do table.insert(all_snippets, v) end

---- This snippet is Evil ----

table.insert(all_snippets,
s(
    {
      trig = "(\\[%w]*)",
      snippetType="autosnippet",
      regTrig=true,
      wordTrig=false,
      priority=2000
    },
    fmta("<>", {f( function(_, snip) return snip.captures[1] end ), }),
    { condition = in_mathzone}
    )
)

return all_snippets

