-- ========================================================
-- ========         coloData Lib v0.2,         ============
-- ========         Pakoskyfrog 2013/03/08     ============
-- ========================================================

------------------------
--  Description
--[[
    This is the library colorData.
    colorData is designed to manipulate colors and provide some handy sortcuts.
    
    DO NOT MODIFY COLOR COMPOSANTS WHILE YU USE THEM,
    since they are tables, you will modify it for everything !
    => use copyColor/copyGradient to create a copy if you want to modify/manipulate one or more of the RGB components.
    The inside named colors are given to you by copy by cd.get{Named,Gradient,Indexed}Color(name), so you will just modify your copy.
    
    TIPS : the get functions return copies of colors, it is better to store them instead of having a repeated get.
]]

------------------------
--  TODO list
--[[
    * handy funcs : HSVtoRGB, HTMLtoRGB, HSL, CMYK, CIEXYZ, CIELab, ...
    * Predefined color lists : indexed:33%, gradients:done
    * func, gradientINtime(T,t) T is period, t is time (just a scale onto index 0..1)
    * func, lighter, darker
    * func, noRed, noGreen, noBlue
]]

local cd  = {}
local cdn = {}
local cdg = {}
local cdi = {}
------------------------
--  Some named colors
do
    cdn.black    = {  0,  0,  0}
    cdn.gray     = {127,127,127} -- gray 50%
    cdn.silver   = {190,190,190} -- gray 75%
    cdn.white    = {255,255,255}

    cdn.red      = {255,  0,  0}
    cdn.green    = {  0,255,  0}
    cdn.blue     = {  0,  0,255}
    cdn.yellow   = {255,255,  0}
    cdn.cyan     = {  0,255,255}
    cdn.magenta  = {255,  0,255}

    cdn.lightRed      = {255,127,127} -- = pink
    cdn.lightGreen    = {127,255,127}
    cdn.lightBlue     = {127,127,255}
    cdn.lightYellow   = {255,255,127}
    cdn.lightCyan     = {127,255,255}
    cdn.lightMagenta  = {255,127,255}

    cdn.darkRed      = {127,  0,  0} -- = maroon
    cdn.darkGreen    = {  0,127,  0}
    cdn.darkBlue     = {  0,  0,127}
    cdn.darkYellow   = {127,127,  0} -- = olive
    cdn.darkCyan     = {  0,127,127} -- = teal
    cdn.darkMagenta  = {127,  0,127} -- = purple

    cdn.orange       = {255,127,  0}
    cdn.rose         = {255,  0,127}
    cdn.springGreen  = {  0,255,127}
    cdn.lime         = {127,255,  0}
    cdn.azure        = {  0,127,255}
    cdn.mauve        = {127,  0,255}

    cdn.pink         = cdn.lightRed
    cdn.teal         = cdn.darkCyan
    cdn.olive        = cdn.darkYellow
    cdn.purple       = cdn.darkMagenta

    cdn.violet       = {238,130,238}
    cdn.indigo       = { 75,  0,130}
    cdn.turquoise    = { 64,224,208}
    cdn.pacifiqueBlue= { 28,169,201}
    cdn.viridian     = { 13,152,186}
    cdn.cerulean     = { 42, 82,190}
    cdn.frost        = {109,155,195}
    cdn.skyBlue      = {135,206,235}
    cdn.royalBlue    = {  0, 35,102}

    cdn.chocolate    = {210,105, 30}
    cdn.brown        = {153,102, 51}
    cdn.brown2       = {150, 75,  0}
    cdn.carrot       = {237,145, 33}
    cdn.peach        = {255,229,180}
    cdn.apricot      = {251,206,177}
    cdn.pumpkin      = {255,117, 24}
    cdn.vermilion    = {227, 66, 52}
    cdn.tomato       = {255, 99, 71}

    cdn.burntSienna  = {233,116, 81}
    cdn.chestnut     = {149, 69, 41}
    cdn.sepia        = {112, 66, 20}
    cdn.bronze       = {205,127, 50}
    cdn.desertSand   = {237,201,175}
    cdn.wheat        = {245,222,179}
    cdn.rust         = {183, 65, 14}
    cdn.camel        = {193,154,107}
    cdn.beige        = {245,245,220}
    cdn.maroon       = cdn.darkRed

    cdn.scarletRose  = {252, 40, 71}
    cdn.coral        = {255,127, 80}
    cdn.scarlet      = {255, 36,  0}
    cdn.fireBrick    = {178, 34, 34}
    cdn.flame        = {226, 88, 34}
    cdn.crimsom      = {220, 20, 60}
    cdn.wine         = {114, 47, 55}
    cdn.carmine      = {150,  0, 24}
    cdn.razzmatazz   = {227, 37,107}

    cdn.fern         = {113,188,120}
    cdn.forestGreen  = { 34,139, 34}
    cdn.asparagus    = {135,169,107}
    cdn.jungle       = { 41,171,135}
    cdn.mantis       = {116,195,101}
    cdn.mossGreen    = {138,154, 91}
    cdn.myrtle       = { 49,120,115}
    cdn.pine         = {  1,121,111}
    cdn.shamrock     = {  0,158, 96}
    cdn.armyGreen    = { 75, 83, 32}
    cdn.bottle       = {  0,106, 78}
    cdn.deepForest   = {  0, 68, 33}

    cdn.sunglow      = {255,204, 51}
    cdn.oldGold      = {207,181, 59}
    cdn.straw        = {228,217,111}
    cdn.jasmine      = {248,222,126}
    cdn.jonquil      = {244,202, 22}
    cdn.vanilla      = {243,229,171}

    cdn.byzantium    = {112, 42, 99}
    cdn.cerise       = {222, 49, 99}
    cdn.heliotrope   = {223,115,255}
    cdn.lavender     = {181,126,220}
    cdn.paleLavender = {220,208,255}
    cdn.halayaUbe    = {102, 56, 84}
    cdn.periwinkle   = {204,204,255}

    cdn.citrine      = {228,208, 10}
    cdn.emerald      = { 80,200,120}
    cdn.ruby         = {224, 17, 95}
    cdn.sapphire     = { 15, 82,186}
    cdn.jade         = {  0,168,107}
    cdn.malachite    = { 11,218, 81}
    cdn.gold         = {255,215,  0}
    cdn.amethyst     = {153,102,204}
    cdn.topaz        = {230,188, 57}
    cdn.diamond      = {222,222,229}
end
do
    local list = {}
    for name, color in pairs(cdn) do
        table.insert(list, name)
    end
    table.sort(list)
    cd.listOfColors = list
end

function cd.existQ(name)
    --------------------
    --  This returns true if the named color exists
    
    return cdn[name] and (3==#cdn[name])
end

function cd.getNamedColor(name)
    --------------------
    --  This will return a copy of a named color
    return cd.copyColor(cdn[name])
end

------------------------
--  Gradients

-- gradients represents shading of colors
-- they are represented by a list a colors
-- and must be interpolated to give a specific color (linearly)

-- a 'regular' list means that the colors are arranged regularlly
-- a 'position' list contains in addition the position 0..1 of the color in the shading
--   example : {'position', {cd.white, 0.2}, {cd.black, 0.5}, {cd.white, 0.8}}
--   if no color points are defined in 0 or 1, the closest color will be taken

cd.listOfGradients = {}
local function addGrad(name, newGrad)
    --------------------
    --  this is used internally to add a gradient to the list of named gradient and into direct access
    cdg[name] = newGrad
    table.insert(cd.listOfGradients, name)
end

-- List of some predetermined gradients :
do
    addGrad('fadeToBlack', {'regular', cdn.white, cdn.black})
    addGrad('fadeToWhite', {'regular', cdn.black, cdn.white})
    addGrad('rainbowClassic', {'regular', cdn.violet, cdn.indigo, cdn.blue, cdn.green, cdn.yellow, cdn.orange, cdn.red})
    addGrad('rainbow', {'regular', {120, 27, 134}, {79, 29, 169}, {63, 57, 196}, {62, 92, 208}, {67, 124, 204}, {78, 149, 188}, {91, 167, 164}, {109, 178, 137}, {130, 186, 112}, {154, 189, 91}, {179, 189, 76}, {202, 183, 66}, {220, 171, 60}, {229, 148, 55}, {230, 115, 48}, {223, 74, 40}, {218, 33, 33}})
    addGrad('sunColors', {'regular', {119, 0, 4}, {209, 31, 1}, {247, 95, 8}, {255, 164, 20}, {255, 209, 32}}) -- dark red to almost yellow
    addGrad('abyssColors', {'regular', {42, 0, 76}, {77, 15, 153}, {60, 83, 212}, {71, 168, 248}, {196, 235,254}}) -- deeeep blue to whity blue
    addGrad('watermelon', {'regular', {25, 25, 25}, {73, 94, 54}, {109, 149, 86}, {146, 191, 125}, {185, 217, 168}, {221, 220, 197}, {242, 185, 185}, {225, 91, 91}})
    addGrad('pastel', {'regular', {194, 120, 239}, {205, 146, 242}, {218, 162, 204}, {229, 175, 173}, {236, 189, 156}, {241, 206, 150}, {244, 223, 150}, {243, 237, 155}, {236, 242, 169}, {219, 237, 193}, {189, 222, 222}, {148, 202, 243}, {109, 180, 236}})
    addGrad('advocado', {"regular", {0, 0, 0}, {0, 112, 19}, {73, 174, 27}, {174, 211, 37}, {255, 251, 58}})
    addGrad('coldAndHot', {"regular", {42, 71, 238}, {91, 146, 241}, {139, 199, 246}, {182, 235, 250}, {220, 253, 253}, {254, 253, 210}, {250, 241, 167}, {240, 208, 122}, {228, 158, 79}, {215, 94, 48}}) -- blue / white / red
    addGrad('beachShade', {"regular", {217, 128, 66}, {224, 160, 72}, {230, 186, 77}, {223, 197, 98}, {203, 194, 140}, {184, 186, 195}, {189, 196, 244}, {255, 255, 255}})
    addGrad('rainbowSpectral', {"regular", {67, 0, 161}, {97, 0, 227}, {112, 0, 255}, {103, 0, 255}, {66, 0, 255}, {18, 17, 255}, {0, 66, 238}, {0, 119, 192}, {0, 154, 146}, {0, 188, 102}, {0, 223, 52}, {0, 250, 0}, {0, 255, 0}, {0, 255, 0}, {0, 255, 0}, {137, 251, 0}, {216, 232, 0}, {250, 202, 0}, {255, 162, 0}, {255, 110, 0}, {255, 28, 0}, {255, 0, 0}, {255, 0, 0}, {247, 0, 0}, {219, 0, 0}, {178, 0, 0}, {139, 0, 0}, {105, 0, 0}, {77, 0, 0}, {55, 0, 0}, {41, 0, 0}, {41, 0, 0}, {41, 0, 0}, {41, 0, 0}, {41, 0, 0}})
    addGrad('aquamarine', {"regular", {173, 187, 216}, {194, 204, 222}, {188, 204, 216}, {166, 193, 204}, {141, 179, 192}, {124, 168, 186}, {127, 169, 192}, {161, 187, 216}})
    addGrad('aurora', {"regular", {66, 66, 66}, {52, 56, 91}, {61, 52, 99}, {80, 57, 96}, {101, 72, 92}, {120, 95, 90}, {132, 120, 96}, {140, 144, 109}, {145, 159, 131}, {148, 163, 160}, {155, 153, 192}, {167, 130, 222}, {188, 99, 241}, {219, 70, 242}})
    addGrad('lagoon', {"regular", {31, 2, 101}, {21, 71, 130}, {24, 127, 139}, {44, 166, 134}, {84, 194, 121}, {145, 214, 104}, {233, 228, 89}})
    addGrad('brassTones', {"regular", {36, 39, 12}, {92, 85, 36}, {167, 151, 70}, {241, 218, 106}, {219, 198, 98}, {224, 202, 100}, {188, 170, 83}, {123, 113, 52}, {44, 42, 13}})
    addGrad('brownToCyan', {"regular", {88, 50, 21}, {142, 106, 74}, {186, 156, 130}, {209, 194, 178}, {213, 225, 219}, {194, 239, 242}, {162, 236, 247}, {128, 217, 239}, {87, 165, 197}})
    addGrad('candy', {"regular", cdn.white, cdn.blue, cdn.white, cdn.green, cdn.white, cdn.red, cdn.white})
    addGrad('CMYKColors', {"regular", {76, 173, 229}, {98, 189, 238}, {126, 164, 220}, {154, 132, 198}, {178, 110, 180}, {198, 106, 164}, {214, 120, 150}, {227, 146, 137}, {236, 175, 127}, {241, 201, 123}, {238, 216, 125}, {227, 216, 134}, {205, 200, 144}, {168, 165, 142}, {113, 111, 112}, {34, 31, 31}})
    addGrad('coffeeStain', {"regular", {103, 84, 70}, {157, 128, 96}, {184, 142, 82}, {207, 167, 94}, {232, 211, 157}, {248, 254, 254}})
    addGrad('terrain', {"regular", {0, 17, 119}, {41, 63, 123}, {74, 99, 125}, {90, 113, 121}, {104, 122, 114}, {114, 124, 103}, {118, 118, 89}, {119, 106, 73}, {119, 95, 59}, {123, 91, 55}, {134, 101, 67}, {161, 134, 107}, {207, 193, 179}, {255, 255, 255}})
    addGrad('france', {"regular", cdn.blue, cdn.white, cdn.red})
    addGrad('rusty', {"regular", {0, 1, 48}, {198, 93, 17}, {255, 120, 9}})
    addGrad('neonGlow', {"regular", {183, 235, 75}, {189, 193, 74}, {194, 151, 72}, {200, 109,71}, {210, 81, 63}, {218, 80, 70}, {218, 84, 98}, {214, 74, 130}, {209, 63, 163}, {205, 53, 196}})
    addGrad('pearlShade', {"regular", {230, 213, 197}, {236, 232, 221}, {211, 216, 204}, {179, 190, 182}, {158, 168, 173}, {154, 160, 181}, {169, 167, 205}, {201, 186, 234}, {242, 206, 250}})
    addGrad('sandyTerrain', {"regular", {167, 80, 52}, {189, 102, 61}, {210, 138, 68}, {228, 176, 74}, {236, 194, 77}, {237, 197, 77}, {232, 194, 76}, {208, 178, 68}, {157, 145, 54}, {111, 116, 48}, {74, 91, 48}})
    addGrad('potery', {"regular", {119, 44, 17}, {202, 91, 24}, {233, 150, 81}, {235, 201, 153}, {232, 224, 206}})
    addGrad('nightShift', {"regular", {22, 37, 51}, {45, 72, 83}, {66, 103, 113}, {103, 142, 143}, {146, 177, 162}, {190, 206, 165}, {220, 219, 152}, {240, 218, 126}, {244, 206, 94}})
    addGrad('love', {"regular", {132, 28, 50}, {157, 41, 68}, {179, 71, 97}, {207, 117, 141}, {236, 170, 190}, {244, 213, 222}})
    addGrad('primary', {"regular", cdn.red, cdn.yellow, cdn.green, cdn.cyan, cdn.blue, cdn.magenta, cdn.red})
    addGrad('secondary', {"regular", cdn.orange, cdn.lime, cdn.springGreen, cdn.azure, cdn.mauve, cdn.rose, cdn.orange})
    addGrad('colorWheel', {"regular", cdn.red, cdn.orange, cdn.yellow, cdn.lime, cdn.green, cdn.springGreen, cdn.cyan, cdn.azure, cdn.blue, cdn.mauve, cdn.magenta, cdn.rose, cdn.red})
    addGrad('jungle', {"regular", {5, 62, 26}, {23, 150, 12}, {120, 200, 75}, {142, 166, 30}, {200, 200, 200}})
    addGrad('leafLife', {"regular", {38, 224, 175}, {65, 178, 127}, {121, 191, 164}, {13, 224,77}, {250, 87, 56}, {238, 193, 15}})
    addGrad('upDown', {"regular", {53, 247, 207}, {19, 36, 177}, {30, 24, 185}, {194, 178, 114}, {68, 162, 76}, {8, 183, 24}, {157, 99, 36}})
    addGrad('paradice', {"regular", {6, 152, 72}, {85, 248, 83}, {235, 188, 218}, {217, 97, 116}, {50, 29, 142}})
    addGrad('phytoplankton', {"regular", {185, 146, 247}, {62, 131, 15}, {73, 80, 248}, {101, 195, 243}, {44, 230, 200}})
    addGrad('bloodAndChrome', {"regular", {158, 146, 141}, {123, 202, 126}, {94, 0, 35}, {222, 208, 22}, {36, 104, 65}})
    addGrad('cumulus', {"regular", {47, 116, 248}, {164, 215, 251}, {245, 245, 255}, {20, 132, 88}})
    addGrad('dropedWine', {"regular", {50, 66, 85}, {218, 25, 66}, {147, 72, 0}, {158, 38, 59}, {138, 55, 26}})
    addGrad('warGames', {"regular", {193, 248, 116}, {87, 106, 9}, {212, 151, 102}, {174, 224,194}, {209, 216, 151}})
    addGrad('pastelHarmony', {"regular", {142, 89, 146}, {194, 92, 224}, {255, 92, 209}, {198, 222,64}, {128, 246, 16}, {33, 206, 222}})
    addGrad('smooth', {"regular", {41, 60, 252}, {10, 115, 252}, {1, 172, 231}, {13, 220, 192}, {45, 249, 142}, {92, 253, 89}, {144, 230, 44}, {194, 186, 12}, {233, 130,1}, {253, 73, 11}, {251, 28, 41}, {227, 3, 86}})
    addGrad('dwarfStar', {"regular", {244, 254, 125}, {218, 225, 72}, {178, 159, 30}, {131, 82, 5}, {84, 21, 2}, {43, 1, 22}, {14, 27, 61}, {1, 91, 111}, {6, 169, 165}, {28, 231, 212}, {64, 254, 244}, {109, 231, 254}})
    addGrad('negative', {"regular", {43, 254, 214}, {142, 234, 169}, {231, 184, 117}, {251, 120, 67}, {188, 57, 27}, {84, 14, 4}, {9, 1, 2}})
    addGrad('goldCoin', {"regular", {20, 4, 1}, {64, 14, 1}, {123, 78, 2}, {183, 166, 3}, {230, 235, 5}, {253, 253, 8}, {247, 212, 10}, {213, 130, 14}})
    addGrad('dreamState', {"regular", {4, 49, 71}, {57, 5, 135}, {148, 11, 196}, {228, 66, 240}, {254, 146, 254}, {211, 219, 236}, {123, 254, 188}, {37, 236, 125}, {1, 173, 63}})
    addGrad('tiklingDeath', {"regular", {246, 23, 138}, {254, 14, 104}, {247, 7, 71}, {225, 3, 42}, {191, 1, 20}, {149, 1, 6}, {104, 4, 1}, {63, 9, 5}, {29, 17, 18}, {7, 27, 39}, {1, 39, 67}, {9, 52, 99}})
    addGrad('unphased', {"regular", {164, 100, 94}, {94, 28, 94}, {32, 0, 94}, {1, 28, 94}, {15, 98, 94}, {66, 181, 94}, {137, 241, 94}, {199, 250, 93}, {228, 206, 93}, {213, 127, 93}, {160, 48, 93}, {90, 4, 93}, {29, 13, 93}, {1, 73, 93}, {17, 156, 93}})
    addGrad('lastKiss', {"regular", {10, 23, 38}, {27, 19, 38}, {52, 14, 39}, {82, 8, 40}, {114, 4, 40}, {145, 1, 41}, {174, 0, 42}, {196, 0, 43}, {210, 3, 43}, {214, 8, 44}, {209, 13, 45}, {195, 18, 46}, {173, 22, 46}, {145, 25, 47}, {113, 26, 48}})
    addGrad('midnight', {"regular", {47, 2, 14}, {64, 2, 27}, {80, 2, 42}, {93, 1, 58}, {102, 1, 73}, {106, 1, 87}, {105, 0, 96}, {99, 0, 102}, {88, 0, 102}, {73, 0, 97}, {56, 0, 88}, {39, 0, 75}, {24, 0, 59}, {11, 0, 43}, {3, 1, 28}})
    addGrad('growth', {"regular", {89, 167, 112}, {115, 182, 132}, {139, 195, 141}, {157, 205, 137}, {169, 212, 121}, {173, 216, 95}, {169, 215, 65}, {157, 212, 37}, {138, 204, 14}, {115, 194, 2}, {89, 181, 2}, {62, 165, 15}, {38, 147, 38}, {19, 129, 67}, {6, 109, 97}})
    addGrad('burnt', {"regular", {167, 165, 159}, {181, 143, 130}, {186, 119, 97}, {182, 95, 64}, {170, 70, 34}, {150, 48, 13}, {125, 29, 2}, {97, 14, 2}, {68, 4, 14}})
    addGrad('iris', {"regular", {96, 214, 32}, {129, 232, 53}, {157, 239, 77}, {178, 236, 102}, {189, 222, 126}, {188, 199, 147}, {176, 168, 163}, {154, 133, 174}, {125, 96, 178}, {92, 62, 174}, {60, 33, 164}, {32, 13, 148}})
    addGrad('lostIdea', {"regular", {25, 81, 53}, {8, 47, 16}, {0, 21, 0}, {5, 5, 10}, {20, 1, 42}, {45, 9, 86}, {76, 29, 130}, {109, 59, 159}, {141, 95, 165}, {168, 133, 145}})
    addGrad('fairyTail', {"regular", {173, 29, 2}, {138, 7, 2}, {93, 0, 11}, {47, 12, 28}, {14, 38, 54}, {0, 73, 84}, {10, 110, 117}, {41, 140, 151}, {85, 157, 183}, {131, 157, 210}, {168, 139, 230}, {187, 109, 242}, {182, 72, 244}, {156, 37, 237}, {114, 11, 222}})
    addGrad('sunshine', {"regular", {31, 199, 235}, {25, 212, 245}, {47, 224, 228}, {92, 234, 188}, {146, 242, 137}, {196, 248, 90}, {226, 252, 60}, {228, 254, 55}, {202, 254, 78}, {156, 251, 121}, {101, 247, 172}, {53, 240, 216}, {27, 232, 242}, {28, 222, 241}})
    addGrad('moonShine', {"regular", {162, 223, 245}, {199, 219, 246}, {216, 214, 245}, {209, 208, 243}, {180, 201, 240}})
    addGrad('weather', {"regular", {200, 195, 161}, {230, 225, 191}, {229, 228, 194}, {221, 226, 196}, {206, 221, 199}, {184, 212, 201}, {158, 201, 203}, {129, 186, 205}, {99, 169, 207}, {71, 150, 209}, {46, 130, 211}, {27, 110, 213}, {14, 91, 215}, {8, 72, 217}, {11, 55, 218}, {21, 41, 220}})
    -- addGrad('', {"regular", })
    
    table.sort(cd.listOfGradients)
end

-- Gradient manipulation functions

function cd.inverseGradient(grad)
    --------------------
    --  This will return a new gradient with colors in reverse order
    
    assert(false, "WIP : not implemented yet.")
    
    local copy = cd.copyGradient(grad)
    table.reverse(copy) -- ?
    return copy
end

function cd.gradToIndexed(grad, N)
    --------------------
    --  This will samples the gradient and make it an indexed list
    -- grad : the gradient
    -- N : length of the future indexed list
    --     if N==nil, N will be taken as the length of the gradient inner samples for the regular types
    
    local indList = {}
    if grad[1]=="regular" then
        N = N or #grad - 1
        local dn = 1/(N-1)
        for i = 0, N-1 do
            table.insert(indList, cd.evalGradientAt(grad, i*dn))
        end
        
    else
        assert(false, "WIP : not implemented yet.")
    end
    
    return indList
end

function cd.getGradientColors(name)
    --------------------
    --  This will return a copy of a gradient shade
    return cd.copyGradient(cdg[name])
end

function cd.evalGradientAt(grad, index)
    --------------------
    --  This will return the inerpolated color of the gradient at index (0..1)
    
    local function line(xa,ya, xb,yb, X)
        -- build on the affine function passing through 2 points
        return X*(ya - yb)/(xa - xb) - (xb*ya - xa*yb)/(xa - xb)
    end
    
    local Gtype = grad[1]
    if Gtype == "regular" then
        if index >= 1-10^-12 then
            return grad[#grad]
        end
        
        local n = #grad - 1                     -- nbr of points
        local di = 1/(n-1)                      -- interval width
        local s = math.floor(index/di) + 1      -- starting interval
        
        -- get boundaries values
        local ra, rb = grad[s+1][1], grad[s+2][1]
        local ga, gb = grad[s+1][2], grad[s+2][2]
        local ba, bb = grad[s+1][3], grad[s+2][3]
        
        -- linear interpolation
        local r = math.floor(line(di*(s-1),ra, di*(s),rb, index))
        local g = math.floor(line(di*(s-1),ga, di*(s),gb, index))
        local b = math.floor(line(di*(s-1),ba, di*(s),bb, index))
        
        return {r,g,b}
    else
        assert(false, "WIP : not implemented yet.")
    end
    
end


------------------------
--  Indexed color lists

-- indexed lists represents collection of colors
-- they are represented by a simple list a colors
-- they can be created from gradients

cd.listOfIndexed = {}
local function addInd(name, newInd)
    --------------------
    --  this is used internally to add a gradient to the list of named gradient and into direct access
    cdi[name] = newInd
    table.insert(cd.listOfIndexed, name)
end

-- List of some predetermined indexed lists :
do
    addInd('RGB', {cdn.red, cdn.green, cdn.blue})
    addInd('CMY', {cdn.cyan, cdn.magenta, cdn.yellow})
    addInd('secondaries', {cdn.orange, cdn.lime, cdn.springGreen, cdn.azure, cdn.mauve, cdn.rose})
    addInd('chained', {{63, 61, 153}, {153, 61, 112}, {153, 139, 61}, {61, 153, 85}, {61, 90, 153}, {153, 61, 143}, {153, 108, 61}, {67, 153, 61}, {61, 120, 153}, {131, 61, 153}, {153, 78, 61}, {97, 153, 61}, {61, 151, 153}, {100, 61, 153}, {153, 61, 74}})
    addInd('colorful', {{0, 0, 0}, {254, 92, 7}, {254, 252, 9}, {138, 182, 7}, {37, 111, 98}, {2, 130, 237}, {39, 29, 125}, {120, 67, 149}, {227, 3, 125}, {231, 7, 33}})
    addInd('earthly', {{117, 36, 36}, {160, 59, 59}, {97, 71, 53}, {150, 113, 86}, {151, 107, 72}, {210, 128, 24}, {249, 176, 82}, {101, 101, 45}, {106, 106, 78}, {161, 161, 63}})
    addInd('goldens', {{255, 192, 11}, {241, 168, 32}, {255, 218, 28}, {216, 143, 8}, {255, 180, 36}, {182, 119, 19}, {255, 202, 74}, {151, 104, 30}, {255, 234, 13}, {94, 71, 22}})
    addInd('heavenly', {{180, 190, 213}, {207, 248, 254}, {195, 243, 232}, {148, 204, 211}, {168, 222, 225}, {157, 192, 231}, {226, 182, 255}, {188, 190, 231}, {197, 161, 234}, {163, 130, 221}, {129, 109, 181}, {100, 85, 143}, {87, 61, 115}})
    addInd('beach', {{253, 245, 56}, {173, 126, 69}, {1, 189, 73}, {21, 89, 241}, {7, 249, 199}, {65, 62, 93}})
    addInd('greens', {{63, 152, 35}, {106, 130, 40}, {55, 185, 66}, {65, 155, 83}, {59, 182, 23}, {127, 174, 5}, {163, 181, 70}, {36, 181, 47}, {25, 125, 105}, {151, 242, 144}, {83, 128, 29}})
    addInd('reds', {{207, 27, 36}, {144, 0, 26}, {245, 0, 59}, {106, 9, 20}, {230, 35, 63}, {255, 56, 60}, {238, 30, 4}, {236, 2, 44}, {234, 43, 67}, {247, 10, 94}})
    addInd('gems', {cdn.diamond, cdn.jade, cdn.citrine, cdn.emerald, cdn.ruby, cdn.sapphire, cdn.malachite, cdn.gold, cdn.amethyst, cdn.topaz})
    addInd('grays10%', {{0, 0, 0}, {25, 25, 25}, {51, 51, 51}, {76, 76, 76}, {102, 102, 102}, {127, 127, 127}, {153, 153, 153}, {178, 178, 178}, {204, 204, 204}, {229, 229, 229}, {255, 255, 255}})
    addInd('reds10%', {{0, 0, 0}, {25, 0, 0}, {51, 0, 0}, {76, 0, 0}, {102, 0, 0}, {127, 0, 0}, {153, 0, 0}, {178, 0, 0}, {204, 0, 0}, {229, 0, 0}, {255, 0, 0}, {255, 25, 25}, {255, 51, 51}, {255, 76, 76}, {255, 102, 102}, {255, 127, 127}, {255, 153, 153}, {255, 178, 178}, {255, 204, 204}, {255, 229, 229}, {255, 255, 255}})
    addInd('greens10%', {{0, 0, 0}, {0, 25, 0}, {0, 51, 0}, {0, 76, 0}, {0, 102, 0}, {0, 127, 0}, {0, 153, 0}, {0, 178, 0}, {0, 204, 0}, {0, 229, 0}, {0, 255, 0}, {25, 255, 25}, {51, 255, 51}, {76, 255, 76}, {102, 255, 102}, {127, 255, 127}, {153, 255, 153}, {178, 255, 178}, {204, 255, 204}, {229, 255, 229}, {255, 255, 255}})
    addInd('blues10%', {{0, 0, 0}, {0, 0, 25}, {0, 0, 51}, {0, 0, 76}, {0, 0, 102}, {0, 0, 127}, {0, 0, 153}, {0, 0, 178}, {0, 0, 204}, {0, 0, 229}, {0, 0, 255}, {25, 25, 255}, {51, 51, 255}, {76, 76, 255}, {102, 102, 255}, {127, 127, 255}, {153, 153, 255}, {178, 178, 255}, {204, 204, 255}, {229, 229, 255}, {255, 255, 255}})
    addInd('cyans10%', cd.gradToIndexed({"regular", cdn.black, cdn.cyan, cdn.white}, 21))
    addInd('magentas10%', cd.gradToIndexed({"regular", cdn.black, cdn.magenta, cdn.white}, 21))
    addInd('yellows10%', cd.gradToIndexed({"regular", cdn.black, cdn.yellow, cdn.white}, 21))
    addInd('midnight', cd.gradToIndexed(cdg.midnight, 7))
    addInd('watermelon', cd.gradToIndexed(cdg.watermelon, 9))
    addInd('pastels', cd.gradToIndexed(cdg.pastel, 11))
    addInd('rainbow', cd.gradToIndexed(cdg.rainbowClassic))
    -- addInd('', {})
    
    table.sort(cd.listOfIndexed)
end

-- Indexed lists manipulation functions
function cd.getIndexedColors(name)
    --------------------
    --  This will return a copy of an indexed list
    return cd.copyIndexed(cdi[name])
end


------------------------
--  Handy functions
function cd.copyColor(clr)
    ------------------------
    --  This will duplicate saftly a color
    -- newColor = cd.copyColor(oldColor)
    return {unpack(clr)}
end

function cd.copyGradient(grad)
    ------------------------
    --  This will duplicate saftly a gradient of colors
    -- newGradient = cd.copyGradient(oldGrad)
    
    local Gtype = grad[1]
    if Gtype == "regular" then
        local copy = {Gtype}
        for i = 2, #grad do
            table.insert(copy, cd.copyColor(grad[i]))
        end
        return copy
        
    else
        assert(false, "WIP : not implemented yet.")
    end
end

function cd.copyIndexed(list)
    --------------------
    --  This will duplicate saftly a gradient of colors
    -- newList = cd.copyGradient(oldList)
    
    local copy = {Gtype}
    for i = 1, #list do
        table.insert(copy, cd.copyColor(list[i]))
    end
    return copy
end

function cd.fractionToRGB(c)
    --------------------
    --  This will convert a RGB color given in 0..1 ranges into a RGB color in 0..255
    local function conv(col)
        return math.floor(col*255)
    end
    
    return {conv(c[1]), conv(c[2]), conv(c[3])}
end

function cd.percentToRGB(c)
    --------------------
    --  This will convert a RGB color given in 0..100 ranges into a RGB color in 0..255
    local function conv(col)
        return math.floor(col*2.55)
    end
    
    return {conv(c[1]), conv(c[2]), conv(c[3])}
end

function cd.HSLToRGB(hslColor)
    --------------------
    --  convertion Hue Saturation Luminosity to RGB255
    -- hslColor = {h=0..360,s=0..1,l=0..1}
    
    local h,s,l  = hslColor[1], hslColor[2], hslColor[3]
    local c = (1-math.abs(2*l-1))*s
    local hp = h/60
    
    local x = c*(1-math.abs((hp%2)-1))
    
    local sori = function (hp)
        if 0<=hp and hp<1 then
            return c,x,0
        elseif 1<=hp and hp<2 then
            return x,c,0
        elseif 2<=hp and hp<3 then
            return 0,c,x
        elseif 3<=hp and hp<4 then
            return 0,x,c
        elseif 4<=hp and hp<5 then
            return x,0,c
        elseif 5<=hp and hp<6 then
            return c,0,x
        else
            return 0,0,0
        end
    end
    
    local r1,g1,b1 = sori(hp)
    local m = l-0.5*c
    
    return r1+m, g1+m, b1+m
end

function cd.HSVToRGB(hsvColor)
    --------------------
    --  convertion Hue Saturation Value to RGB255
    -- hsvColor = {h=0..360,s=0..1,v=0..1}
    
    local h,s,v  = hsvColor[1], hsvColor[2], hsvColor[3]
    local c = v*s
    local hp = h/60
    
    local x = c*(1-math.abs((hp%2)-1))
    
    local sori = function (hp)
        if 0<=hp and hp<1 then
            return c,x,0
        elseif 1<=hp and hp<2 then
            return x,c,0
        elseif 2<=hp and hp<3 then
            return 0,c,x
        elseif 3<=hp and hp<4 then
            return 0,x,c
        elseif 4<=hp and hp<5 then
            return x,0,c
        elseif 5<=hp and hp<6 then
            return c,0,x
        else
            return 0,0,0
        end
    end
    
    local r1,g1,b1 = sori(hp)
    local m = v-c
    
    return r1+m, g1+m, b1+m
end

function cd.CMYKToRGB()
    --------------------
    --  convertion Cyan Magenta Yellow Black to RGB255
    assert(false, "WIP : not implemented yet.")
    
    
end

function cd.CIEXYZToRGB(xyzColor)
    --------------------
    --  convertion CIE XYZ to RGB255 if possible
    
    function matVecMult(m,v)
        local C = #m[1]
        local L = #m
        local b = {}
        for i = 1, L do
            for j = 1, C do
                b[i] = (b[i] or 0) + m[i][j] * v[j]
            end
        end
        return b
    end
    
    -- mtx to make the reverse transformation
    -- local Am = {{0.4124, 0.3576, 0.1805},
                -- {0.2126, 0.7152, 0.0722},
                -- {0.0193, 0.1192, 0.9505}}
    
    local Am = {{ 3.2406, -1.5372, -0.4986},
                {-0.9686,  1.8758,  0.0415},
                { 0.0557, -0.2040,  1.0570}}

    local b = {xyzColor[1], xyzColor[2], xyzColor[3]}
    b = matVecMult(Am, b)
    
    local ClinToCsrgb = function (clin)
        local a = 0.055
        if clin <= 0.0031308 then
            return 12.92*clin
        else
            return (1+a)*math.pow(clin, 1/2.4) - a
        end
        
    end
    
    return {math.floor(255*ClinToCsrgb(b[1])), math.floor(255*ClinToCsrgb(b[2])), math.floor(255*ClinToCsrgb(b[3]))}
end

function cd.CIELabToRGB()
    --------------------
    --  convertion CIE L*a*b* to RGB255 if possible
    assert(false, "WIP : not implemented yet.")
end

function cd.noRed(clr)
    --------------------
    --  Will set all R values to zero. Work directly on the given color/gradient even if it returns it.
    assert(false, "WIP : not implemented yet.")
end

function cd.noGreen(clr)
    --------------------
    --  Will set all G values to zero. Work directly on the given color/gradient even if it returns it.
    assert(false, "WIP : not implemented yet.")
end

function cd.noBlue(clr)
    --------------------
    --  Will set all B values to zero. Work directly on the given color/gradient even if it returns it.
    assert(false, "WIP : not implemented yet.")
end

function cd.lighter(clr, fraction)
    --------------------
    --  Will add a fraction 0..1 of white to the color, making it brighter.
    assert(false, "WIP : not implemented yet.")
end

function cd.darker(clr, fraction)
    --------------------
    --  Will substract a fraction 0..1 of white to the color, making it darker.
    assert(false, "WIP : not implemented yet.")
end

function cd.addColors(clr, addClr)
    --------------------
    --  Will add addClr to clr, addClr must be a simple color.
    assert(false, "WIP : not implemented yet.")
end




-- assert(false, "WIP : not implemented yet.")

print("colorData lib loaded.")
return cd