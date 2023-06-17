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

--[[ Old version with VimTeX]]
local in_mathzone = function()
  -- The `in_mathzone` function requires the VimTeX plugin
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end

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
  ["ch"] = "chi",
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

  ["AA"] = "A",
  ["DD"] = "D",
  ["EE"] = "E",
  ["FF"] = "F",

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
  ["ii"] = "in",

  ["QQ"] = "Q",
  ["CC"] = "C",
  ["RR"] = "R",
  ["NN"] = "N",
  ["ZZ"] = "Z",

  ["min"] = "min",
  ["max"] = "max",
  ["inf"] = "inf",
  ["sup"] = "sup",
  ["ex"] = "exists",
  ["fa"] = "forall",
  ["iff"] = "iff",
  ["imp"] = "implies",
  ["to"] = "to",
  ["mt"] = "mapsto",
  ["oo"] = "infty",
  ["wt"] = "widetilde",
  ["11"] = "1",
  ["kn"] = ",|\\,",
  ["qd"] = "quad",
  ["BB"] = "Big",
  ["bb"] = "big",
  ["bl"] = "bigl",
  ["br"] = "bigr",
  ["BL"] = "Bigl",
  ["BR"] = "Bigr",

  ["df"] = "diff",
}

local simple_math_snippets = {}
for key, val in pairs(simple_table) do
  table.insert(simple_math_snippets,
    s(
      { trig = key, snippetType = "autosnippet", },
      t("\\" .. val .. " "),
      { condition = in_mathzone })
  )
end

local other_math_snippets = {
  s({ trig = "^", snippetType = "autosnippet", wordTrig = false, priority = 3000 },
    fmta("^{<>}", { i(1), }),
    { condition = in_mathzone }),

  s({ trig = "_", snippetType = "autosnippet", wordTrig = false, priority = 3000 },
    fmta("_{<>}", { i(1), }),
    { condition = in_mathzone, wordTrig = false }),

  s({ trig = "ff", snippetType = "autosnippet" },
    fmta("\\frac{<>}{<>}", { i(1), i(2), }),
    { condition = in_mathzone }),

  s({ trig = "nn", snippetType = "autosnippet" },
    fmta("\\| <> \\|_{<>} ", { i(1), i(2), }),
    { condition = in_mathzone }),

  s({ trig = "ceil", snippetType = "autosnippet" },
    fmta("\\lceil <> \\rceil ", { i(1), }),
    { condition = in_mathzone }),

  s({ trig = "floor", snippetType = "autosnippet" },
    fmta("\\lfloor <> \\rfloor ", { i(1), }),
    { condition = in_mathzone }),

  s({ trig = "sc", snippetType = "autosnippet" },
    fmta("\\langle <>, <> \\rangle ", { i(1), i(2), }),
    { condition = in_mathzone }),

  s({ trig = "set", snippetType = "autosnippet" },
    fmta("\\{ <> \\} ", { i(1), }),
    { condition = in_mathzone }),

  s({ trig = "int", snippetType = "autosnippet" },
    fmta("\\int_{<>}^{<>} <> \\diff <> ", { i(1), i(2), i(4), i(3) }),
    { condition = in_mathzone }),

  s({ trig = "sum", snippetType = "autosnippet" },
    fmta("\\sum_{<>}^{<>} ", { i(1), i(2), }),
    { condition = in_mathzone }),

  s({ trig = "prod", snippetType = "autosnippet" },
    fmta("\\prod_{<>}^{<>} ", { i(1), i(2), }),
    { condition = in_mathzone }),

  s({ trig = "bun", snippetType = "autosnippet" },
    fmta("\\bigcup_{<>}^{<>} ", { i(1), i(2), }),
    { condition = in_mathzone }),

  s({ trig = "sq", snippetType = "autosnippet" },
    fmta("\\sqrt{<>} ", { i(1), }),
    { condition = in_mathzone }),

  s({ trig = "ee", snippetType = "autosnippet" },
    fmta("e^{<>} ", { i(1), }),
    { condition = in_mathzone }),

  s({ trig = "tt", snippetType = "autosnippet" },
    fmta("\\text{<>} ", { i(1), }),
    { condition = in_mathzone }),
}


local environments_snippets = {
  s({ trig = "beg", snippetType = "autosnippet" },
    fmta([[
\begin{<>}
<>
\end{<>}]], { i(1), i(0), rep(1) }),
    { condition = line_begin }),

  s({ trig = "bal", snippetType = "autosnippet" },
    fmta([[
\begin{align*}
<>
\end{align*}]], { i(0) }),
    { condition = line_begin }),

  s({ trig = "leq", snippetType = "autosnippet" },
    fmta([[
\begin{equation}
\label{eq:<>}
<>
\end{equation}]], { i(1), i(0) }),
    { condition = line_begin }),

  s({ trig = "sec", snippetType = "autosnippet" },
    fmta([[
\section{<>}

<>]], { i(1), i(0) }),
    { condition = line_begin }),

  s({ trig = "ssec", snippetType = "autosnippet" },
    fmta([[
\section{<>}

<>]], { i(1), i(0) }),
    { condition = line_begin }),

  s({ trig = "MM", snippetType = "autosnippet" },
    fmta([[
\[
  <>
\]
]], { i(1) }),
    {}),

  s({ trig = "ccol", snippetType = "autosnippet" },
    fmta("{\\color{<>} <> } ", { i(1), i(0) }),
    {}),

  s({ trig = "cref", snippetType = "autosnippet" },
    fmta([[\cref{<>} ]], { i(1) }),
    {}),
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
      snippetType = "autosnippet",
      regTrig = true,
      wordTrig = false,
      priority = 2000
    },
    fmta("<>", { f(function(_, snip) return snip.captures[1] end), }),
    { condition = in_mathzone }
  )
)

return all_snippets
