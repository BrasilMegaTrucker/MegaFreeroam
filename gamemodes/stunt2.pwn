/*
    Mega Freeroam - Modo: Stunt/DM/Drift/Race
    *        By Nic[K] e Delete_

    # SA-MP 0.3z

*/
AntiDeAMX()
{
    new a[][] =
    {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

new const Novidades[][] =
{
    {"Novidades Mega Freeroam\n\n"},
    {"v0.1 - Release Inicial"}
};

//Dados de conexão do MySQL

#define mysql_host "localhost"
#define mysql_usuario "root"
#define mysql_senha ""
#define mysql_db "mf"

#include <a_samp>
native gpci(playerid, const serial[ ], maxlen);

#include <sscanf2>
#include <streamer>
#include <mSelection>
#include <a_mysql>
#include <zcmd>

#define MAILER_URL "brasilmegatrucker.com/email.php"
#include <mailer>


#pragma dynamic 50000

#pragma tabsize 0

/****************************
	Definções de Dialogs
*****************************/
#define DialogRegistrar   1
#define DialogLogar       2
#define DialogIntroRadio  3
#define DialogTeleportLista 4
#define DialogVeiculoClasse 5
#define DialogComandos      6
#define DialogComandosClasse 7
#define DialogArenasDM       8
#define DialogDescalar       9
#define DialogTeleStunt      10
#define DialogTelePistas    11
#define DialogTeleDrift     12
#define DialogTelePulos    13
#define DialogTeleCorridas  14
#define DialogTeleTubos     15
#define DialogTeleVariado   16
#define DialogTeleNormal    17
#define DialogRadio         18
#define DialogMudarSenha    19
#define DialogNovaSenha     20
#define DialogConfirmarSenha 21
#define DialogPorNeon       22
#define DialogRodas         23
#define DialogVehCor        24

#define DialogCorridas      25
#define DialogMenuCorrida 26
#define DialogEditCorridaNome 27
#define DialogEditCorridaPremio 28
#define DialogApagarCorrida     29
#define DialogEditCorridaVeiculo    30
#define DialogEditCorridaMaxPlayers 31
#define DialogEditCorridaTipo       32
#define DialogBansSeriais           33
#define DialogSerialInfo            34

#define DialogCriarGang             35
#define DialogGangDescricao         36
#define DialogGangCor               37
#define DialogGangTAG               38
#define DialogGangTerTAG            39
#define DialogGangSubLider          40
#define DialogGangCorP              41
#define DialogGangMenu              42
#define DialogGangConvidarMembro          43
#define DialogGangAdcSubLider 		44
#define DialogDeletarGang           45
#define DialogGangEditarDescricao    46
#define DialogGangDeletar           47
#define DialogGangMembros           48
#define DialogGangAreas             49
#define DialogGangAreaOpcoes        50
#define DialogDemitirMembro         51
#define DialogGangs                 52
#define DialogInfoGang              53
#define DialogGangAreaNome          54
#define DialogGangAreaEditNome      55

#define DialogSemResposta 25000

/*
    Outras Defines e Variaveis
*/
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

//by NicK


#define AMMO 100000

#define Versao      "v0.1"
#undef MAX_PLAYERS
#define MAX_PLAYERS 1001

#define MAX_CHECKPOINTS     100
#define MAX_CORRIDAS        50
#define MAX_GANGZONES       150

#define MAX_GANGS   100
#define MAX_GANG_MEMBROS    100
#define MAX_GANG_AREAS      50

#define MAX_AREAS   150

#define COR_AREA    0x80808080

#define ClasseMotos 1
#define ClasseBarco 2
#define ClasseConversivel 3
#define ClasseHelicoptero 4
#define ClasseIndustrial 5
#define ClasseLowRider 6
#define ClasseOffRoad 7
#define ClasseAviao 8
#define ClassePublico 9
#define ClasseSalao 10
#define ClasseSport 11
#define ClasseTrailer 12
#define ClasseUnicos 13
#define ClasseBasicos 14

enum iVehClasse
{
    vNome[50],
    vClasse,
    vModeloID
}

new CorTeles[3] =
{
    0x00FF00FF,
    0xFFFF00FF,
    0x00BFFFFF
};
static const ClasseVeiculo[][iVehClasse] =
{
	{"Admiral", ClasseSalao, 445},
	{"Alpha", ClasseSport, 602},
	{"Ambulance", ClassePublico, 416},
	{"Andromada", ClasseAviao, 592},
	{"Trailer Báu", ClasseTrailer, 591},
	{"AT400", ClasseAviao, 577},
	{"Baggage", ClasseUnicos, 485},
	{"Baggage Trailer A", ClasseTrailer, 606},
	{"Baggage Trailer B", ClasseTrailer, 607},
	{"Bandito", ClasseOffRoad, 568},
	{"Banshee", ClasseSport, 429},
	{"Barracks", ClassePublico, 433},
	{"Beagle", ClasseAviao, 511},
	{"Benson", ClasseIndustrial, 499},
	{"Berkley's RC Van", ClasseIndustrial, 459},
	{"BF Injection", ClasseOffRoad, 424},
	{"BF-400", ClasseMotos, 581},
	{"Bike", ClasseMotos, 509},
	{"Blade", ClasseLowRider, 536},
	{"Blista Compact", ClasseSport, 496},
	{"Bloodring Banger", ClasseSalao, 504},
	{"BMX", ClasseMotos, 481},
	{"Bobcat", ClasseIndustrial, 422},
	{"Boxville 1", ClasseIndustrial, 498},
	{"Boxville 2", ClasseIndustrial, 609},
	{"Bravura", ClasseSalao, 401},
	{"Broadway", ClasseLowRider, 575},
	{"Buccaneer", ClasseSalao, 518},
	{"Buffalo", ClasseSport, 402},
	{"Bullet", ClasseSport, 541},
	{"Burrito", ClasseIndustrial, 482},
	{"Bus", ClassePublico, 431},
	{"Cabbie", ClassePublico, 438},
	{"Caddy", ClasseUnicos, 457},
	{"Cadrona", ClasseSalao, 527},
	{"Camper", ClasseUnicos, 483},
	{"Trailer Baú", ClasseTrailer, 435},
	{"Cargobob", ClasseHelicoptero, 548},
	{"Cement Truck", ClasseIndustrial, 524},
	{"Cheetah", ClasseSport, 415},
	{"Clover", ClasseSalao, 542},
	{"Club", ClasseSport, 589},
	{"Coach", ClassePublico, 437},
	{"Coastguard", ClasseBarco, 472},
	{"Combine Harvester", ClasseUnicos, 532},
	{"Comet", ClasseConversivel, 480},
	{"Cropduster", ClasseAviao, 512},
	{"DFT-30", ClasseIndustrial, 578},
	{"Dinghy", ClasseBarco, 473},
	{"Dodo", ClasseAviao, 593},
	{"Dozer", ClasseUnicos, 486},
	{"Dumper", ClasseUnicos, 406},
	{"Dune", ClasseOffRoad, 573},
	{"Elegant", ClasseSalao, 507},
	{"Elegy", ClasseSalao, 562},
	{"Emperor", ClasseSalao, 585},
	{"Enforcer", ClassePublico, 427},
	{"Esperanto", ClasseSalao, 419},
	{"Euros", ClasseSport, 587},
	{"Faggio", ClasseMotos, 462},
	{"Farm Trailer", ClasseTrailer, 610},
	{"FBI Rancher", ClassePublico, 490},
	{"FBI Truck", ClassePublico, 528},
	{"FCR-900", ClasseMotos, 521},
	{"Feltzer", ClasseConversivel, 533},
	{"Firetruck", ClassePublico, 407},
	{"Firetruck LA", ClassePublico, 544},
	{"Flash", ClasseSport, 565},
	{"Flatbed", ClasseIndustrial, 455},
	{"Trailer Fluídos", ClasseTrailer, 584},
	{"Forklift", ClasseUnicos, 530},
	{"Fortune", ClasseSalao, 526},
	{"Freeway", ClasseMotos, 463},
	{"Glendale", ClasseSalao, 466},
	{"Glendale Shit", ClasseSalao, 604},
	{"Greenwood", ClasseSalao, 492},
	{"Hermes", ClasseSalao, 474},
	{"Hotdog", ClasseUnicos, 588},
	{"Hotknife", ClasseUnicos, 434},
	{"Hotring Racer 1", ClasseSport, 494},
	{"Hotring Racer 2", ClasseSport, 502},
	{"Hotring Racer 3", ClasseSport, 503},
	{"HPV1000", ClassePublico, 523},
//	{"Hunter", ClasseHelicoptero, 425},
	{"Huntley", ClasseOffRoad, 579},
	{"Hustler", ClasseUnicos, 545},
//	{"Hydra", ClasseAviao, 520},
	{"Infernus", ClasseSport, 411},
	{"Intruder", ClasseSalao, 546},
	{"Jester", ClasseSport, 559},
	{"Jetmax", ClasseBarco, 493},
	{"Journey", ClasseUnicos, 508},
	{"Kart", ClasseUnicos, 571},
	{"Landstalker", ClasseOffRoad, 400},
	{"Launch", ClasseBarco, 595},
	{"Leviathan", ClasseHelicoptero, 417},
	{"Linerunner", ClasseIndustrial, 403},
	{"Majestic", ClasseSalao, 517},
	{"Manana", ClasseSalao, 410},
	{"Marquis", ClasseBarco, 484},
	{"Maverick", ClasseHelicoptero, 487},
	{"Merit", ClasseSalao, 551},
	{"Mesa", ClasseOffRoad, 500},
	{"Monster", ClasseOffRoad, 444},
	{"Monster A", ClasseOffRoad, 556},
	{"Monster B", ClasseOffRoad, 557},
	{"Moonbeam", ClasseBasicos, 418},
	{"Mountain Bike", ClasseMotos, 510},
	{"Mower", ClasseUnicos, 572},
	{"Mr Whoopee", ClasseUnicos, 423},
	{"Mule", ClasseIndustrial, 414},
	{"Nebula", ClasseSalao, 516},
	{"Nevada", ClasseAviao, 553},
	{"Newsvan", ClasseIndustrial, 582},
	{"NRG-500", ClasseMotos, 522},
	{"Oceanic", ClasseSalao, 467},
	{"Ore Trailer", ClasseTrailer, 450},
	{"Packer", ClasseIndustrial, 443},
	{"Patriot", ClasseOffRoad, 470},
	{"PCJ-600", ClasseMotos, 461},
	{"Perenniel", ClasseBasicos, 404},
	{"Phoenix", ClasseSport, 603},
	{"Picador", ClasseIndustrial, 600},
	{"Pizzaboy", ClasseMotos, 448},
	{"Police Car (LSPD)", ClassePublico, 596},
	{"Police Car (LVPD)", ClassePublico, 598},
	{"Police Car (SFPD)", ClassePublico, 597},
	{"Police Maverick", ClasseHelicoptero, 497},
	{"Police Ranger", ClassePublico, 599},
	{"Pony", ClasseIndustrial, 413},
	{"Predator", ClasseBarco, 430},
	{"Premier", ClasseSalao, 426},
	{"Previon", ClasseSalao, 436},
	{"Primo", ClasseSalao, 547},
	{"Quad", ClasseMotos, 471},
	{"Raindance", ClasseHelicoptero, 563},
	{"Rancher 1", ClasseOffRoad, 489},
	{"Rancher 2", ClasseOffRoad, 505},
	{"Reefer", ClasseBarco, 453},
	{"Regina", ClasseBasicos, 479},
	{"Remington", ClasseLowRider, 534},
//    {"Rhino", ClassePublico, 432},
	{"Roadtrain", ClasseIndustrial, 515},
	{"Romero", ClasseUnicos, 442},
	{"Rumpo", ClasseIndustrial, 440},
	{"Rustler", ClasseAviao, 476},
	{"Sabre", ClasseSport, 475},
	{"Sadler", ClasseIndustrial, 543},
	{"Sadler Shit", ClasseIndustrial, 605},
	{"SAN News Maverick", ClasseHelicoptero, 488},
	{"Sanchez", ClasseMotos, 468},
	{"Sandking", ClasseOffRoad, 495},
	{"Savanna", ClasseLowRider, 567},
	{"Seasparrow", ClasseHelicoptero, 447},
	{"Securicar", ClasseUnicos, 428},
	{"Sentinel", ClasseSalao, 405},
	{"Shamal", ClasseAviao, 519},
	{"Skimmer", ClasseAviao, 460},
	{"Slamvan", ClasseLowRider, 535},
	{"Solair", ClasseBasicos, 458},
	{"Sparrow", ClasseHelicoptero, 469},
	{"Speeder", ClasseBarco, 452},
	{"Squallo", ClasseBarco, 446},
	{"Stafford", ClasseSalao, 580},
	{"Stallion", ClasseConversivel, 439},
	{"Stratum", ClasseBasicos, 561},
	{"Stretch", ClasseUnicos, 409},
	{"Stuntplane", ClasseAviao, 513},
	{"Sultan", ClasseSalao, 560},
	{"Sunrise", ClasseSalao, 550},
	{"Super GT", ClasseSport, 506},
	{"S.W.A.T.", ClassePublico, 601},
	{"Sweeper", ClasseUnicos, 574},
	{"Tahoma", ClasseLowRider, 566},
	{"Tampa", ClasseSalao, 549},
	{"Tanker", ClasseIndustrial, 514},
	{"Taxi", ClassePublico, 420},
	{"Tornado", ClasseLowRider, 576},
	{"Towtruck", ClasseUnicos, 525},
	{"Tractor", ClasseIndustrial, 531},
	{"Trashmaster", ClasseIndustrial, 408},
	{"Tropic", ClasseBarco, 454},
	{"Tug", ClasseUnicos, 583},
	{"Tug Stairs Trailer", ClasseTrailer, 608},
	{"Turismo", ClasseSport, 451},
	{"Uranus", ClasseSport, 558},
	{"Utility Trailer", ClasseTrailer, 611},
	{"Utility Van", ClasseIndustrial, 552},
	{"Vincent", ClasseSalao, 540},
	{"Virgo", ClasseSalao, 491},
	{"Voodoo", ClasseLowRider, 412},
	{"Vortex", ClasseUnicos, 539},
	{"Walton", ClasseIndustrial, 478},
	{"Washington", ClasseSalao, 421},
	{"Wayfarer", ClasseMotos, 586},
	{"Willard", ClasseSalao, 529},
	{"Windsor", ClasseConversivel, 555},
    {"Yankee", ClasseIndustrial, 456},
	{"Yosemite", ClasseIndustrial, 554},
	{"ZR-350", ClasseSport, 477}
};
new CorNome[] =
{
    0xFF8C13AA,0xC715FFAA,0x20B2AAAA,0xDC143CAA,0x6495EDAA,0xf0e68cAA,0x778899AA,
    0xFF1493AA,0xF4A460AA,0xEE82EEAA,0xFFD720AA,0x8b4513AA,0x4949A0AA,0x148b8bAA,
    0x14ff7fAA,0x556b2fAA,0x0FD9FAAA,0x10DC29AA,0x534081AA,0x0495CDAA,0xEF6CE8AA,
    0xBD34DAAA,0x247C1BAA,0x0C8E5DAA,0x635B03AA,0xCB7ED3AA,0x65ADEBAA,0x5C1ACCAA,
    0xF2F853AA,0x11F891AA,0x7B39AAAA,0x53EB10AA,0x54137DAA,0x275222AA,0xF09F5BAA,
    0x3D0A4FAA,0x22F767AA,0xD63034AA,0x9A6980AA,0xDFB935AA,0x3793FAAA,0x90239DAA,
    0xE9AB2FAA,0xAF2FF3AA,0x057F94AA,0xB98519AA,0x388EEAAA,0x028151AA,0xA55043AA,
    0x0DE018AA,0x93AB1CAA,0x95BAF0AA,0x369976AA,0x18F71FAA,0x4B8987AA,0x491B9EAA,
    0x829DC7AA,0xBCE635AA,0xCEA6DFAA,0x20D4ADAA,0x2D74FDAA,0x3C1C0DAA,0x12D6D4AA,
    0x48C000AA,0x2A51E2AA,0xE3AC12AA,0xFC42A8AA,0x2FC827AA,0x1A30BFAA,0xB740C2AA,
    0x42ACF5AA,0x2FD9DEAA,0xFAFB71AA,0x05D1CDAA,0xC471BDAA,0x94436EAA,0xC1F7ECAA,
    0xCE79EEAA,0xBD1EF2AA,0x93B7E4AA,0x3214AAAA,0x184D3BAA,0xAE4B99AA,0x7E49D7AA,
    0x4C436EAA,0xFA24CCAA,0xCE76BEAA,0xA04E0AAA,0x9F945CAA,0xDCDE3DAA,0x10C9C5AA,
    0x70524DAA,0x0BE472AA,0x8A2CD7AA,0x6152C2AA,0xCF72A9AA,0xE59338AA,0xEEDC2DAA,
    0xD8C762AA,0x3FE65CAA,0xffff00AA,0x669933AA,0xcc3366AA,0x66ff00AA,0x339900AA,
    0xcc0033AA,0x009900AA,0x6600ffAA,0x66cc33AA,0x333300AA,0x9933ffAA,0x99ff66AA,
	0xcc0000AA,0x000033AA,0x33ff00AA,0x666666AA,0xccccccAA,0xff00ffAA,0xFFFF80AA,
    0x006600AA,0x3300ffAA,0x009966AA,0xff9900AA,0x00ff66AA,0x00ffffAA,0x66cc00AA,
    0x3300ccAA,0x669966AA,0x33cc66AA,0x00ff99AA,0x993300AA,0xccff99AA,0xff9933AA,
    0x330000AA,0x333333AA,0xccff99AA,0x993399AA,0xffcc66AA,0x660066AA,0x99cc00AA,
    0x0000FFAA,0xFF4500AA,0xFFDEADAA,0x8B3E2FAA,0xCDAD00AA,0x00E5EEAA,0xD2691EAA,
    0xA0522DAA,0x006400AA,0xFFDEADAA,0x9ACD32AA,0x228B22AA,0x6B8E23AA,0xBDB76BAA,
    0xEEE8AAAA,0xFAFAD2AA,0xFFFFE0AA,0xFFFF00AA,0xFFD700AA,0xEEDD82AA,0xDAA520AA,
    0xA9A9A9AA,0x00008BAA,0x008B8BAA,0x8B008BAA,0x8B0000AA,0x90EE90AA,0xCD661DAA,
    0x8B4513AA,0xCD853FAA,0x545454AA,0x77bbddAA,0xbef666AA,0xbbdd33AA,0x77ddbbAA,
    0x80FF80AA,0x00FF80AA,0x80FFFFAA,0x0080FFAA,0xFF80C0AA,0xFF80FFAA,0xFF0000AA,
    0xFFFF00AA,0x00FF40AA,0x80FF00AA,0x00FFFFAA,0x0080C0AA,0x8080C0AA,0xFF00FFAA,
    0x804040AA,0xFF8040AA,0x00FF00AA,0x008080AA,0x004080AA,0x8080FFAA,0x800040AA,
    0xFF0080AA,0x800000AA,0xFF8000AA,0x008000AA,0x008040AA,0x0000FFAA,0x0000A0AA,
    0x800080AA,0x800080AA,0x8000FFAA,0x400000AA,0x804000AA,0x004000AA,0x004040AA,
    0x000080AA,0x000040AA,0x400040AA,0x400080AA,0x000000AA,0x808000AA,0x808040AA,
    0x808080AA,0x408080AA,0xC0C0C0AA,0x400040AA,0x400040AA,0xFFFFFFAA,0xFF8080AA
};
static const NomesVeiculos[][] = {
    "Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster",
    "Stretch","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto",
    "Taxi","Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee",
    "Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo",
    "RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer Minerio",
    "Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer",
    "PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot",
    "Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina","Comet","BMX",
    "Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo",
    "Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa",
    "RC Goblin","H. Racer A","H. Racer B","Bloodring Banger","Rancher","Super GT","Elegant",
    "Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic",
    "Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona",
    "FBI Truck","Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight",
    "Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob",
    "Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus",
    "Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight",
    "Trem Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford",
    "BF-400","Newsvan","Tug","Trailer Fluidos","Emperor","Wayfarer","Euros","Hotdog","Club","Vagao Trem","Trailer Bau",
    "Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)","Police Car (LVPD)","Police Ranger",
    "Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
    "Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};
enum infNeon
{
	NeonCor[50],
	NeonID
}
static const Neons[][infNeon] = {
	{"Nulo", 0},
	{"Neon Vermelho", 18647},
	{"Neon Azul", 18648},
	{"Neon Verde", 18649},
	{"Neon Amarelo", 18650},
	{"Neon Rosa", 18651},
	{"Neon Branco", 18652}
};
enum infRodas
{
	RodaNome[50],
	RodaID
}
static const Rodas[][infRodas] = {
	{"Shadow", 1073},
	{"Mega", 1074},
	{"Rimshine", 1075},
	{"Wires", 1076},
	{"Classic", 1077},
	{"Twist", 1078},
	{"Cutter", 1079},
	{"Switch", 1080},
	{"Grove", 1081},
	{"Import", 1082},
	{"Dollar", 1083},
	{"Trance", 1084},
	{"Atomic", 1085},
	{"Off-Road", 1025}
};

static const CoresVeiculos[] = {
	0x000000FF, 0xF5F5F5FF, 0x2A77A1FF, 0x840410FF, 0x263739FF, 0x86446EFF, 0xD78E10FF, 0x4C75B7FF, 0xBDBEC6FF, 0x5E7072FF,
	0x46597AFF, 0x656A79FF, 0x5D7E8DFF, 0x58595AFF, 0xD6DAD6FF, 0x9CA1A3FF, 0x335F3FFF, 0x730E1AFF, 0x7B0A2AFF, 0x9F9D94FF,
	0x3B4E78FF, 0x732E3EFF, 0x691E3BFF, 0x96918CFF, 0x515459FF, 0x3F3E45FF, 0xA5A9A7FF, 0x635C5AFF, 0x3D4A68FF, 0x979592FF,
	0x421F21FF, 0x5F272BFF, 0x8494ABFF, 0x767B7CFF, 0x646464FF, 0x5A5752FF, 0x252527FF, 0x2D3A35FF, 0x93A396FF, 0x6D7A88FF,
	0x221918FF, 0x6F675FFF, 0x7C1C2AFF, 0x5F0A15FF, 0x193826FF, 0x5D1B20FF, 0x9D9872FF, 0x7A7560FF, 0x989586FF, 0xADB0B0FF,
	0x848988FF, 0x304F45FF, 0x4D6268FF, 0x162248FF, 0x272F4BFF, 0x7D6256FF, 0x9EA4ABFF, 0x9C8D71FF, 0x6D1822FF, 0x4E6881FF,
	0x9C9C98FF, 0x917347FF, 0x661C26FF, 0x949D9FFF, 0xA4A7A5FF, 0x8E8C46FF, 0x341A1EFF, 0x6A7A8CFF, 0xAAAD8EFF, 0xAB988FFF,
	0x851F2EFF, 0x6F8297FF, 0x585853FF, 0x9AA790FF, 0x601A23FF, 0x20202CFF, 0xA4A096FF, 0xAA9D84FF, 0x78222BFF, 0x0E316DFF,
	0x722A3FFF, 0x7B715EFF, 0x741D28FF, 0x1E2E32FF, 0x4D322FFF, 0x7C1B44FF, 0x2E5B20FF, 0x395A83FF, 0x6D2837FF, 0xA7A28FFF,
	0xAFB1B1FF, 0x364155FF, 0x6D6C6EFF, 0x0F6A89FF, 0x204B6BFF, 0x2B3E57FF, 0x9B9F9DFF, 0x6C8495FF, 0x4D8495FF, 0xAE9B7FFF,
	0x406C8FFF, 0x1F253BFF, 0xAB9276FF, 0x134573FF, 0x96816CFF, 0x64686AFF, 0x105082FF, 0xA19983FF, 0x385694FF, 0x525661FF,
	0x7F6956FF, 0x8C929AFF, 0x596E87FF, 0x473532FF, 0x44624FFF, 0x730A27FF, 0x223457FF, 0x640D1BFF, 0xA3ADC6FF, 0x695853FF,
	0x9B8B80FF, 0x620B1CFF, 0x5B5D5EFF, 0x624428FF, 0x731827FF, 0x1B376DFF, 0xEC6AAEFF, 0x000000FF,
	// (0.3x)
	0x177517FF, 0x210606FF, 0x125478FF, 0x452A0DFF, 0x571E1EFF, 0x010701FF, 0x25225AFF, 0x2C89AAFF, 0x8A4DBDFF, 0x35963AFF,
	0xB7B7B7FF, 0x464C8DFF, 0x84888CFF, 0x817867FF, 0x817A26FF, 0x6A506FFF, 0x583E6FFF, 0x8CB972FF, 0x824F78FF, 0x6D276AFF,
	0x1E1D13FF, 0x1E1306FF, 0x1F2518FF, 0x2C4531FF, 0x1E4C99FF, 0x2E5F43FF, 0x1E9948FF, 0x1E9999FF, 0x999976FF, 0x7C8499FF,
	0x992E1EFF, 0x2C1E08FF, 0x142407FF, 0x993E4DFF, 0x1E4C99FF, 0x198181FF, 0x1A292AFF, 0x16616FFF, 0x1B6687FF, 0x6C3F99FF,
	0x481A0EFF, 0x7A7399FF, 0x746D99FF, 0x53387EFF, 0x222407FF, 0x3E190CFF, 0x46210EFF, 0x991E1EFF, 0x8D4C8DFF, 0x805B80FF,
	0x7B3E7EFF, 0x3C1737FF, 0x733517FF, 0x781818FF, 0x83341AFF, 0x8E2F1CFF, 0x7E3E53FF, 0x7C6D7CFF, 0x020C02FF, 0x072407FF,
	0x163012FF, 0x16301BFF, 0x642B4FFF, 0x368452FF, 0x999590FF, 0x818D96FF, 0x99991EFF, 0x7F994CFF, 0x839292FF, 0x788222FF,
	0x2B3C99FF, 0x3A3A0BFF, 0x8A794EFF, 0x0E1F49FF, 0x15371CFF, 0x15273AFF, 0x375775FF, 0x060820FF, 0x071326FF, 0x20394BFF,
	0x2C5089FF, 0x15426CFF, 0x103250FF, 0x241663FF, 0x692015FF, 0x8C8D94FF, 0x516013FF, 0x090F02FF, 0x8C573AFF, 0x52888EFF,
	0x995C52FF, 0x99581EFF, 0x993A63FF, 0x998F4EFF, 0x99311EFF, 0x0D1842FF, 0x521E1EFF, 0x42420DFF, 0x4C991EFF, 0x082A1DFF,
	0x96821DFF, 0x197F19FF, 0x3B141FFF, 0x745217FF, 0x893F8DFF, 0x7E1A6CFF, 0x0B370BFF, 0x27450DFF, 0x071F24FF, 0x784573FF,
	0x8A653AFF, 0x732617FF, 0x319490FF, 0x56941DFF, 0x59163DFF, 0x1B8A2FFF, 0x38160BFF, 0x041804FF, 0x355D8EFF, 0x2E3F5BFF,
	0x561A28FF, 0x4E0E27FF, 0x706C67FF, 0x3B3E42FF, 0x2E2D33FF, 0x7B7E7DFF, 0x4A4442FF, 0x28344EFF
};
static const AVehicleModPrices[] =
{
	400, // ID 1000, Spoiler Pro								Certain Transfender cars
	550, // ID 1001, Spoiler Win								Certain Transfender cars
	200, // ID 1002, Spoiler Drag								Certain Transfender cars
	250, // ID 1003, Spoiler Alpha								Certain Transfender cars
	100, // ID 1004, Hood Champ Scoop							Certain Transfender cars
	150, // ID 1005, Hood Fury Scoop							Certain Transfender cars
	80, // ID 1006, Roof Roof Scoop								Certain Transfender cars
	500, // ID 1007, Sideskirt Right Sideskirt					Certain Transfender cars
	500, // ID 1008, Nitro 5 times								Most cars, Most planes and Most Helicopters
	200, // ID 1009, Nitro 2 times								Most cars, Most planes and Most Helicopters
	1000, // ID 1010, Nitro 10 times                 			Most cars, Most planes and Most Helicopters
	220, // ID 1011, Hood Race Scoop                			Certain Transfender cars
	250, // ID 1012, Hood Worx Scoop                			Certain Transfender cars
	100, // ID 1013, Lamps Round Fog                			Certain Transfender cars
	400, // ID 1014, Spoiler Champ                  			Certain Transfender cars
	500, // ID 1015, Spoiler Race                   			Certain Transfender cars
	200, // ID 1016, Spoiler Worx                   			Certain Transfender cars
	500, // ID 1017, Sideskirt Left Sideskirt       			Certain Transfender cars
	350, // ID 1018, Exhaust Upswept                			Most cars
	300, // ID 1019, Exhaust Twin                   			Most cars
	250, // ID 1020, Exhaust Large                  			Most cars
	200, // ID 1021, Exhaust Medium								Most cars
	150, // ID 1022, Exhaust Small								Most cars
	350, // ID 1023, Spoiler Fury                   			Certain Transfender cars
	50, // ID 1024, Lamps Square Fog							Certain Transfender cars
	1000, // ID 1025, Wheels Offroad							Certain Transfender cars
	480, // ID 1026, Sideskirt Right Alien Sideskirt			Sultan
	480, // ID 1027, Sideskirt Left Alien Sideskirt				Sultan
	770, // ID 1028, Exhaust Alien                      		Sultan
	680, // ID 1029, Exhaust X-Flow								Sultan
	370, // ID 1030, Sideskirt Left X-Flow Sideskirt    		Sultan
	370, // ID 1031, Sideskirt Right X-Flow Sideskirt   		Sultan
	170, // ID 1032, Roof Alien Roof Vent						Sultan
	120, // ID 1033, Roof X-Flow Roof Vent              		Sultan
	790, // ID 1034, Exhaust Alien								Elegy
	150, // ID 1035, Roof X-Flow Roof Vent						Elegy
	500, // ID 1036, SideSkirt Right Alien Sideskirt    		Elegy
	690, // ID 1037, Exhaust X-Flow								Elegy
	190, // ID 1038, Roof Alien Roof Vent						Elegy
	390, // ID 1039, SideSkirt Right X-Flow Sideskirt   		Elegy
	500, // ID 1040, SideSkirt Left Alien Sideskirt				Elegy
	390, // ID 1041, SideSkirt Right X-Flow Sideskirt   		Elegy
	1000, // ID 1042, SideSkirt Right Chrome Sideskirt			Broadway
	500, // ID 1043, Exhaust Slamin                     		Broadway
	500, // ID 1044, Exhaust Chrome								Broadway
	510, // ID 1045, Exhaust X-Flow								Flash
	710, // ID 1046, Exhaust Alien								Flash
	670, // ID 1047, SideSkirt Right Alien Sideskirt    		Flash
	530, // ID 1048, SideSkirt Right X-Flow Sideskirt			Flash
	810, // ID 1049, Spoiler Alien								Flash
	620, // ID 1050, Spoiler X-Flow                     		Flash
	670, // ID 1051, SideSkirt Left Alien Sideskirt     		Flash
	530, // ID 1052, SideSkirt Left X-Flow Sideskirt			Flash
	130, // ID 1053, Roof X-Flow								Flash
	210, // ID 1054, Roof Alien									Flash
	230, // ID 1055, Roof Alien									Stratum
	520, // ID 1056, Sideskirt Right Alien Sideskirt			Stratum
	430, // ID 1057, Sideskirt Right X-Flow Sideskirt			Stratum
	620, // ID 1058, Spoiler Alien								Stratum
	720, // ID 1059, Exhaust X-Flow								Stratum
	530, // ID 1060, Spoiler X-Flow								Stratum
	180, // ID 1061, Roof X-Flow								Stratum
	520, // ID 1062, Sideskirt Left Alien Sideskirt				Stratum
	430, // ID 1063, Sideskirt Left X-Flow Sideskirt			Stratum
	830, // ID 1064, Exhaust Alien								Stratum
	850, // ID 1065, Exhaust Alien								Jester
	750, // ID 1066, Exhaust X-Flow								Jester
	250, // ID 1067, Roof Alien									Jester
	200, // ID 1068, Roof X-Flow								Jester
	550, // ID 1069, Sideskirt Right Alien Sideskirt			Jester
	450, // ID 1070, Sideskirt Right X-Flow Sideskirt			Jester
	550, // ID 1071, Sideskirt Left Alien Sideskirt				Jester
	450, // ID 1072, Sideskirt Left X-Flow Sideskirt			Jester
	1100, // ID 1073, Wheels Shadow								Most cars
	1030, // ID 1074, Wheels Mega								Most cars
	980, // ID 1075, Wheels Rimshine							Most cars
	1560, // ID 1076, Wheels Wires								Most cars
	1620, // ID 1077, Wheels Classic							Most cars
	1200, // ID 1078, Wheels Twist								Most cars
	1030, // ID 1079, Wheels Cutter								Most cars
	900, // ID 1080, Wheels Switch								Most cars
	1230, // ID 1081, Wheels Grove								Most cars
	820, // ID 1082, Wheels Import								Most cars
	1560, // ID 1083, Wheels Dollar								Most cars
	1350, // ID 1084, Wheels Trance								Most cars
	770, // ID 1085, Wheels Atomic								Most cars
	100, // ID 1086, Stereo Stereo								Most cars
	1500, // ID 1087, Hydraulics Hydraulics						Most cars
	150, // ID 1088, Roof Alien									Uranus
	650, // ID 1089, Exhaust X-Flow								Uranus
	450, // ID 1090, Sideskirt Right Alien Sideskirt			Uranus
	100, // ID 1091, Roof X-Flow								Uranus
	750, // ID 1092, Exhaust Alien								Uranus
	350, // ID 1093, Sideskirt Right X-Flow Sideskirt			Uranus
	450, // ID 1094, Sideskirt Left Alien Sideskirt				Uranus
	350, // ID 1095, Sideskirt Right X-Flow Sideskirt			Uranus
	1000, // ID 1096, Wheels Ahab								Most cars
	620, // ID 1097, Wheels Virtual								Most cars
	1140, // ID 1098, Wheels Access								Most cars
	1000, // ID 1099, Sideskirt Left Chrome Sideskirt			Broadway
	940, // ID 1100, Bullbar Chrome Grill						Remington
	780, // ID 1101, Sideskirt Left `Chrome Flames` Sideskirt	Remington
	830, // ID 1102, Sideskirt Left `Chrome Strip` Sideskirt	Savanna
	3250, // ID 1103, Roof Convertible							Blade
	1610, // ID 1104, Exhaust Chrome							Blade
	1540, // ID 1105, Exhaust Slamin							Blade
	780, // ID 1106, Sideskirt Right `Chrome Arches`			Remington
	780, // ID 1107, Sideskirt Left `Chrome Strip` Sideskirt	Blade
	780, // ID 1108, Sideskirt Right `Chrome Strip` Sideskirt	Blade
	1610, // ID 1109, Rear Bullbars Chrome						Slamvan
	1540, // ID 1110, Rear Bullbars Slamin						Slamvan
	55, // ID 1111, Front Sign? Little Sign?					Slamvan         ???
	55, // ID 1112, Front Sign? Little Sign?					Slamvan         ???
	3340, // ID 1113, Exhaust Chrome							Slamvan
	3250, // ID 1114, Exhaust Slamin							Slamvan
	2130, // ID 1115, Front Bullbars Chrome						Slamvan
	2050, // ID 1116, Front Bullbars Slamin						Slamvan
	2040, // ID 1117, Front Bumper Chrome						Slamvan
	780, // ID 1118, Sideskirt Right `Chrome Trim` Sideskirt	Slamvan
	940, // ID 1119, Sideskirt Right `Wheelcovers` Sideskirt	Slamvan
	780, // ID 1120, Sideskirt Left `Chrome Trim` Sideskirt		Slamvan
	940, // ID 1121, Sideskirt Left `Wheelcovers` Sideskirt		Slamvan
	780, // ID 1122, Sideskirt Right `Chrome Flames` Sideskirt	Remington
	860, // ID 1123, Bullbars Bullbar Chrome Bars				Remington
	780, // ID 1124, Sideskirt Left `Chrome Arches` Sideskirt	Remington
	1120, // ID 1125, Bullbars Bullbar Chrome Lights			Remington
	3340, // ID 1126, Exhaust Chrome Exhaust					Remington
	3250, // ID 1127, Exhaust Slamin Exhaust					Remington
	3340, // ID 1128, Roof Vinyl Hardtop						Blade
	1650, // ID 1129, Exhaust Chrome							Savanna
	3380, // ID 1130, Roof Hardtop								Savanna
	3290, // ID 1131, Roof Softtop								Savanna
	1590, // ID 1132, Exhaust Slamin							Savanna
	830, // ID 1133, Sideskirt Right `Chrome Strip` Sideskirt	Savanna
	800, // ID 1134, SideSkirt Right `Chrome Strip` Sideskirt	Tornado
	1500, // ID 1135, Exhaust Slamin							Tornado
	1000, // ID 1136, Exhaust Chrome							Tornado
	800, // ID 1137, Sideskirt Left `Chrome Strip` Sideskirt	Tornado
	580, // ID 1138, Spoiler Alien								Sultan
	470, // ID 1139, Spoiler X-Flow								Sultan
	870, // ID 1140, Rear Bumper X-Flow							Sultan
	980, // ID 1141, Rear Bumper Alien							Sultan
	150, // ID 1142, Vents Left Oval Vents						Certain Transfender Cars
	150, // ID 1143, Vents Right Oval Vents						Certain Transfender Cars
	100, // ID 1144, Vents Left Square Vents					Certain Transfender Cars
	100, // ID 1145, Vents Right Square Vents					Certain Transfender Cars
	490, // ID 1146, Spoiler X-Flow								Elegy
	600, // ID 1147, Spoiler Alien								Elegy
	890, // ID 1148, Rear Bumper X-Flow							Elegy
	1000, // ID 1149, Rear Bumper Alien							Elegy
	1090, // ID 1150, Rear Bumper Alien							Flash
	840, // ID 1151, Rear Bumper X-Flow							Flash
	910, // ID 1152, Front Bumper X-Flow						Flash
	1200, // ID 1153, Front Bumper Alien						Flash
	1030, // ID 1154, Rear Bumper Alien							Stratum
	1030, // ID 1155, Front Bumper Alien						Stratum
	920, // ID 1156, Rear Bumper X-Flow							Stratum
	930, // ID 1157, Front Bumper X-Flow						Stratum
	550, // ID 1158, Spoiler X-Flow								Jester
	1050, // ID 1159, Rear Bumper Alien							Jester
	1050, // ID 1160, Front Bumper Alien						Jester
	950, // ID 1161, Rear Bumper X-Flow							Jester
	650, // ID 1162, Spoiler Alien								Jester
	450, // ID 1163, Spoiler X-Flow								Uranus
	550, // ID 1164, Spoiler Alien								Uranus
	850, // ID 1165, Front Bumper X-Flow						Uranus
	950, // ID 1166, Front Bumper Alien							Uranus
	850, // ID 1167, Rear Bumper X-Flow							Uranus
	950, // ID 1168, Rear Bumper Alien							Uranus
	970, // ID 1169, Front Bumper Alien							Sultan
	880, // ID 1170, Front Bumper X-Flow						Sultan
	990, // ID 1171, Front Bumper Alien							Elegy
	900, // ID 1172, Front Bumper X-Flow						Elegy
	950, // ID 1173, Front Bumper X-Flow						Jester
	1000, // ID 1174, Front Bumper Chrome						Broadway
	900, // ID 1175, Front Bumper Slamin						Broadway
	1000, // ID 1176, Rear Bumper Chrome						Broadway
	900, // ID 1177, Rear Bumper Slamin							Broadway
	2050, // ID 1178, Rear Bumper Slamin						Remington
	2150, // ID 1179, Front Bumper Chrome						Remington
	2130, // ID 1180, Rear Bumper Chrome						Remington
	2050, // ID 1181, Front Bumper Slamin						Blade
	2130, // ID 1182, Front Bumper Chrome						Blade
	2040, // ID 1183, Rear Bumper Slamin						Blade
	2150, // ID 1184, Rear Bumper Chrome						Blade
	2040, // ID 1185, Front Bumper Slamin						Remington
	2095, // ID 1186, Rear Bumper Slamin						Savanna
	2175, // ID 1187, Rear Bumper Chrome						Savanna
	2080, // ID 1188, Front Bumper Slamin						Savanna
	2200, // ID 1189, Front Bumper Chrome						Savanna
	1200, // ID 1190, Front Bumper Slamin						Tornado
	1040, // ID 1191, Front Bumper Chrome						Tornado
	940, // ID 1192, Rear Bumper Chrome							Tornado
	1100, // ID 1193 Rear Bumper Slamin							Tornado
};

#define cmd_conta 1
#define cmd_geral 2
#define cmd_veiculo 3
#define cmd_admin 4
enum infoCmds
{
    ComandoLevel,
    ComandoClasse,
    ComandoNome[128],
    ComandoInfo[128],
}
static const Cmds[][infoCmds] =
{
	{0, cmd_veiculo, "/cor",        "Muda a cor de seu veículo"},
	{0, cmd_veiculo, "/rodas",      "Põe uma roda personalzada em seu veículo"},
	{0, cmd_veiculo, "/nos",        "Adiciona nitro em seu veículo"},
	{0, cmd_veiculo, "/suspensao", "Adicione uma suspensão hydraulica em seu carro!"},
	{0, cmd_veiculo, "/meuveh",    "Pega o ultimo veículo criado por você (/v)"},
	{0, cmd_conta, "/email [seu e-mail]",        "Definir o mudar o e-mail definido, para recuperar a senha"},
    {0, cmd_conta, "/mudarsenha",  "Mudar a senha"},
    {0, cmd_geral, "/admins", "visualiza os admins on-line"},
    {0, cmd_geral, "/arenas", "arenas para dm"},
    {0, cmd_geral, "/contar", "Inicia uma contagem"},
    {0, cmd_geral, "/para", "Ganha um paraquedas"},
    {0, cmd_geral, "/v", "cria algum veículo"},
    {0, cmd_geral, "/teles", "teleportes disponíveis"},
    {0, cmd_conta, "/pagar [id/nome] [quantia]", "paga em dinheiro algum jogador"},
    {0, cmd_geral, "/mp [id/nome] [mensagem]", "envia uma mensagem para outro player"},
    {0, cmd_geral, "/eu [mensagem]", "anuncia algo no servidor"},
    {0, cmd_geral, "/relato [id/nome] [mensagem]", "relata um jogador para administração"},
    {0, cmd_veiculo, "/teclas", "teclas (atalhos para funções em seu veículo)"},
    {0, cmd_geral, "/armas", "seleção de armas"},
    {0, cmd_conta, "/mudarnick [novo nick]", "muda o nick-name"},
    {0, cmd_geral, "/vida", "restaura a vida"},
    {0, cmd_conta, "/afk", "fica ausente"},
    {0, cmd_conta, "/sairafk", "sai do modo afk"},
    {0, cmd_geral, "/jogadoresafk", "visualiza todos os jogadores afk"},
    {0, cmd_geral, "/colete", "põe um colete"},
    {0, cmd_conta, "/skin", "altera a skin"},
    {0, cmd_geral, "/morrer", "morre, não irá contar no número de mortes"},
    {1, cmd_admin, "/a [texto]", "chat de admin"},
    {1, cmd_admin, "/tapa [id/nome]", "dá um tapa"},
    {1, cmd_admin, "/veh [modelo id]", "cria um veículo pelo id"},
    {1, cmd_admin, "/ir [id/nome]", "vai até um jogador"},
    {1, cmd_admin, "/trazer [id/nome]", "puxa um jogador"},
    {1, cmd_admin, "/irpara [x] [y] [z]", "vai até uma posição xyz"},
    {1, cmd_admin, "/ann [mensagem]", "anuncia algo no servidor."},
    {1, cmd_admin, "/kick [id/nome] [motivo]", "kicka um jogador do servidor"},
    {1, cmd_admin, "/banip [id/nome] [motivo]", "bane um jogador por ip do servidor"},
    {2, cmd_admin, "/cnn [mensagem]", "outro anuncio"},
    {2, cmd_admin, "/delveh [id]", "deleta um veículo por id"},
	{3, cmd_admin, "/criardinheiro [quantidade]", "Cria uma quantidade em dinheiro"},
    {4, cmd_admin, "/setgold [id] [golds]", "Seta os golds de alguém"},
    {4, cmd_admin, "/setinfos [id] [mortes] [matou]", "Seta informações de alguém"},
    {4, cmd_admin, "/setscore [id] [scores]", "Seta informações"},
	{5, cmd_admin, "/forcarcmd [id/nome] [comando] [parametros extras]", "Força um jogador a usar um comando."},
    {5, cmd_admin, "/daradmin [id/nome] [level]", "seta o level admin de um player"}
};
/*
    mSelection (ID's)
*/
new SKIN_LISTA;
new ARMA_LISTA;

#define LISTA_VEICULOS 1
/*
    Variaveis

*/
new Flooder[MAX_PLAYERS];
new IsFlooding[MAX_PLAYERS];


enum iWebRadios
{
    NomeWebRadio[100],
    ipWebRadio[128]
}
new WebRadios[][iWebRadios] =
{
    {"{ffff00}Rádio Brasil Mega Trucker", "http://radio.brasilmegatrucker.com:10698"},
    {"Sound Pop", "http://173.193.202.68:7460/"},
    {"Total Dance", "http://74.222.2.146:9358/"},
    {"Rádio Fusion", "http://65.60.34.34:8000/"},
    {"All Hits Station", "http://199.195.192.234:9998/"},
    {"Mega Som", "http://174.142.196.188:8048/"},
    {"Rádio Dance", "http://173.193.201.100:8068/"},
    {"Radio Hunter", "http://live.hunterfm.com/live"},
    {"Rap 181 FM", "http://108.61.73.117:8054/"},
    {"Flow 103", "http://173.245.71.186:80/"},
    {"Dance Hits Chicago", "http://wms-21.streamsrus.com:10025/"},
    {"Forró", "http://64.15.147.220:7120/"},
    {"Som Sertanejo", "http://64.15.147.221:12016/"},
    {"Funk Neurótico", "http://64.56.64.76:16506/"},
    {"Radio Mandela Digital", "http://184.154.37.136:12842/"},
    {"Rádio Rock", "http://suaradio1.dyndns.ws:10584/stream"},
    {"Reggaeton 24/7", "http://192.81.248.32:8160/"},
    {"Hot Hits", "http://206.217.213.235:8290/"}
};
enum iContagem
{
    Text:DrawContagem,
    TextoContagem[128],
    ContagemSegundos
}
new Contagem[iContagem];

enum pInfo
{
    pNome[MAX_PLAYER_NAME],
    pSenha[50],
    pLevel,
    pDinheiro,
    pScore,
    pGold,
    
    pRegistroDia[50],
    pUltimoLogin,
	//Veiculo
	pVeh,
    VehModelo,
    VehComponentes[14],
	VehCores[2],
	VehPintura,
	NeonID,
	//Outros
    pAvisos,
    //Sistema DM
    pMorreu,
    pMatou,
    //Status
    pTempoBan,
    pBans,
    pTempoJogado,
    pTempoLogado,
    // Sistemas Corrida
    pCorridas,
    bool:EmCorrida,
    pCorridaCheckpoint,
    PlayerText:CorridaPosInfo,
    pCorridaPos,
    pCorridaVeh,
    CorridaID, //ID da corrida
    //Sistema Drift'
    pDriftPontos,
    pDriftBonus,
    pDriftPontosTotal,
    PlayerText:DriftDraw[2],
    ModoDrift,

	pEmail[128],
    bool:Logado,
    Mudo,
    bool:Morrer,
    ArenaID,
    bool:EmArena,
    pEspiando,
    pErrosSenha, //Erros da Senha
    pRelatoTempo,
    PlayerText:DrawInfo,
    PlayerText:Velocimetro,
    PlayerText:InfoMatador[2],
    PlayerText:DrawStatus[11],
    PlayerText:PlayerDano[9],
    bool:MostrarDano,
    bool:AFK,
    pAvisoPing,
    bool:pCameraConnect,
    bool:Teclas,
    
    pGang, //ID da Gang no MySQL
    pConviteGang, //Tal gang convidando-o
    
    //FPS
    pFPS,
    pDLevel,

    pMySQL_ID, //id do mysql
	ORM:OrmID //Sistemas de ORM do MySQL
}
new PlayerInfo[MAX_PLAYERS][pInfo];
new mysql; //conexão mysql


enum vehInfos
{
	vehModelo,
	vehCores[2],
	vehPintura,
	//Interior,
	//Mundo,
	NeonEsquerdo,
	NeonDireito,
	NeonID,
	vehComponentes[14],
	
	DonoID //ID do Player que é Dono.
}
new VehInfo[MAX_VEHICLES][vehInfos];

#define CORRIDA_TERRESTRE  1
#define CORRIDA_AEREA       2

enum sisCorrida
{
	CorridaNome[128],
	Float:CheckpointX[MAX_CHECKPOINTS],
	Float:CheckpointY[MAX_CHECKPOINTS],
	Float:CheckpointZ[MAX_CHECKPOINTS],

	MaxCheckpoints,
	Float:InicioPos[3],
	CorridaPremio,
//	CorridaVoltas,
	CorridaTipo,
 	CorridaPosicao[MAX_CHECKPOINTS],
	CorridaRecord,
	RecordBy,
	CorridaTempo, //No caso quando a corrida for iniciada
	CorridaContagemSegundos, //Iniciar a contagem!
	CorridaMaxParticipantes,

	CorridaTimerContagem,
	CorridaTimerIniciar,

	CorridaVeiculo,
	CorridaID, //ID do MYSQL
	Text:CorridaDraws[4],
	
	bool:Iniciada,
	bool:Carregada,
	bool:EmProjeto,
	bool:InicioDefinido,
	bool:Trancada
}
new Corridas[MAX_CORRIDAS][sisCorrida];
/*
	O MAX_CORRIDAS serve para definir máximo de corridas simutâneas.
	
	O Sistema, irá funcionar com corridas de diferentes tipos.

	O próprio player deve estar com seu devido veículo.
	Também, o veículo pode ser estipulado pelo criador/editor da corrida.
	
	Players não podem editar uma corrida. Apenas, abrir uma corrida, e esperar o número máximo de participantes na corrida.
	Apenas, administradores, podem criar e editar corridas.
*/


//TextDraws
new Text:Draws[12];
new Text:DrawAnuncio;

static const Float:SpawnLocais[][4] = {
    {-2347.14, -1621.67, 483.66, 298.83}, //Chiliad
    {422.75, 2529.62, 16.63, 150.0}, //Aero Abandonado
    {1872.46, -2526.36, 13.54, 90.0},  //Aeroporto LS
    {1990.85, 1547.87, 12.0, 132.15},  //Barco Pirata LV
    {-2595.37, 1389.59, 7.0, 366.20}, //SF - Bayside
    {-1361.26, -227.83, 13.87, 366.0}, //Aeroporto SF
    {1295.24, 1399.25, 10.82, 289.71}, //Aeroporto LV
    {-37.13, -91.06, 3.11, 266.93} //Fazenda EasterBoard
};

#define Tele_Stunt 0
#define Tele_Pistas 1
#define Tele_Drift 2
#define Tele_Pulos 3
#define Tele_Corrida 4
#define Tele_Tubos 5
#define Tele_Variados 6
#define Tele_Normal 7

new TeleTipo[][] =
{
    {"Stunt (/stunts)"},
    {"Pistas (/pistas)"},
    {"Drift (/drift)"},
    {"Pulos (/pulos)"},
    {"Corridas (/corridas)"},
    {"Tubos (/tubos)"},
    {"Variados (/varios)"},
    {"Normais (/tlnormal)"},
    {"Arenas DM (/arenas)"}
};
enum teleportInfo
{
    teleportNome[128],
    TeleCmd[32],
    teleTipo,
    Float:tX,
    Float:tY,
    Float:tZ,
    Float:tRot,
    bool:tCarregar
}
static const Teleportes[][teleportInfo] =
{
    {"Chilliad", "chiliad", Tele_Stunt, -2347.14, -1621.67, 483.66, 298.83, false},
    {"Aero Abandonado", "aeroabandonado", Tele_Stunt, 422.75, 2529.62, 16.63, 150.0, false},
    {"Represa", "represa", Tele_Stunt, -485.26, 2255.93, 50.86, 132.41, false},
    {"Aeroporto LS", "aerols", Tele_Stunt, 1872.46, -2526.36, 13.54, 90.0, false},
    {"Praia Santa Maria", "praiasm", Tele_Stunt, 338.02, -1761.70, 5.22, 193.49, false},
    {"LV - Piratas Stunt", "pirataslv", Tele_Stunt, 1990.85, 1547.87, 12.0, 132.15, false},
    {"Fazenda EasterBoard", "easterboard", Tele_Stunt, -37.13, -91.06, 3.11, 266.93, false},
    {"San Fierro", "sfstunt", Tele_Stunt, -2595.37, 1389.59, 7.0, 238.0, false},
    {"Aeroporto SF", "aerosf", Tele_Stunt, -1361.26, -227.83, 13.87, 366.0, false},
    {"Aeroporto LV", "aerolv", Tele_Stunt, 1295.24, 1399.25, 10.82, 289.71, false},
    {"Golf Stunt", "golf", Tele_Stunt, 1413.6228, 2730.4304, 10.8703, 289.71, false},
    {"Drop 1", "drop1", Tele_Pistas, 849.8343,-2622.8064,798.7162, 0.0, false},
    {"Drop 2", "drop2", Tele_Pistas, 3849.5476,-1059.3527,930.3063, 90.0, false},
    {"Drop 3", "drop3", Tele_Pistas, 978.82, 1739.84, 1012.84, 90.0, true},
    {"Drop 4", "drop4", Tele_Pistas, 1250.09, 2800.61, 1555.12, 180.0, false},
    {"Twister", "twister", Tele_Pistas, 684.7673,442.7378,620.7108,293.0, false},
    {"Loop", "loop", Tele_Pistas, 3351.33, -2540.65, 736.50, 17.50, false},
    {"Loop 2", "loop2", Tele_Pistas, -227.09, 980.19, 1312.80, 269.42, false},
    {"Insano", "insano1", Tele_Pistas, -2520.12, 157.85, 3231.90, 0.0, false},
    {"Insano 2", "insano2", Tele_Pistas, 886.52, 874.84, 936.11, 359.33, false},
    {"Insano 3", "insano3", Tele_Pistas, -1611.91, -719.59, 1527.79, 103.64, false},
    {"Roller", "roller", Tele_Pistas, -170.3976,-2241.1484,28.2542, 17.50, false},
    {"Infernus Paradise", "ip", Tele_Pistas, -214.542678, -8175.392578, 35.225547,293.0, false},
    {"Tubo Água", "tuboagua", Tele_Tubos, -306.93, 371.07, -35.24, 107.0, false},
    {"Espiral", "espiral", Tele_Tubos, 248.87, 841.87, 362.70, 51.99, false},
    {"Tubo SF", "tubosf", Tele_Tubos, -1422.95, 998.31, 7.18, 89.25, false},
    {"Pulo Insano", "puloinsano", Tele_Pulos, 2446.29, -1005.70, 960.30, 260.0, false},
    {"Big Tunel", "bigtunel", Tele_Pulos, 2226.05, 1500.28, 3864.46, 120.88, false},
    {"Super Rampa", "superrampa", Tele_Pulos, 1463.5081,-2443.6111,1122.5062, 345.0, false},
    {"Sky", "sky", Tele_Pulos, 2765.53,-2346.63,5135.85, 260.0, false},
    {"Trampolim", "trampolim", Tele_Variados, 973.25, 1246.26, 410.0, 359.33, false},
    {"Festa", "festa", Tele_Variados, 1299.0125, -227.7760, 11.5673, 359.33, false},
    {"Monster Parkour", "monsterpk", Tele_Variados, -2909.6707,71.3213,3.7526, 180.0, false},
    {"Drift 1", "drift1", Tele_Drift, -295.22, 1536.13, 75.56, 177.28, false},
    {"Drift 2", "drift2", Tele_Drift, -2394.7258, -588.6559, 132.3384, 177.28, false},
    {"Drag", "drag", Tele_Corrida, 2557.99, -252.52, 71.27, 52.57, false},
    {"Nascar", "nascar", Tele_Corrida, 1782.13, -2347.31, 486.40, 184.32, false},
    {"Circuito LV", "circuitolv", Tele_Corrida, 3296.49, 1234.61, 18.15, 50.98, false},
    {"Los Santos", "lossantos", Tele_Normal, 1855.14, -1290.57, 13.04, 0.0, false},
    {"Los Santos - Transfender", "lstransfender", Tele_Normal, 1065.06, -1032.01, 31.72, 90.0, false},
	{"Los Santos - Low'Riders", "lslow", Tele_Normal, 2637.79, -2002.55,13.21, 235.12, false},
    {"San Fierro", "sanfierro", Tele_Normal, -1976.40, 544.83, 34.67, 90.0, false},
    {"San Fierro - Transfender", "sftransfender", Tele_Normal, -1917.05, 277.81, 40.70, 206.02, false},
    {"San Fierro - Street Racing (Tunning)", "sftunning", Tele_Normal, -2712.75, 230.53, 3.98, 179.20, false},
    {"Las Venturas", "lasventuras", Tele_Normal, 2074.66, 1246.14, 10.33, 0.0, false},
    {"Las Venturas - Transfender", "lvtransfender", Tele_Normal, 2392.83, 987.43, 10.47, 1.0, false},
    {"Bay Side", "bayside", Tele_Normal, -2482.62, 2225.10, 4.50, 359.72, false},
	{"Angel Pine", "angelpine", Tele_Normal, -2112.53, -2425.24, 30.28, 146.36, false},
	{"El Quebrados", "elquebrados", Tele_Normal, -1411.67, 2640.81, 55.34, 88.27, false},
	{"Las Barrancas", "lasbarrancas", Tele_Normal, -859.74, 1546.95, 22.84, 231.23, false},
	{"Forte Carson", "fortcarson", Tele_Normal, -153.50, 1090.02, 19.40, 58.57, false},
	{"Blueberry", "blueberry", Tele_Normal, 219.40, -157.24, 1.23, 292.72, false},
	{"Dillimore", "dillimore", Tele_Normal, 661.46, -586.25, 15.99, 215.82, false},
	{"Palomino Creek", "palomino", Tele_Normal, 2279.75, -84.24, 26.17, 193.99, false},
	{"Montgomery", "montgomery", Tele_Normal, 1373.78, 272.75, 19.19, 13.03, false}
};
enum iAreas
{
    ArenaNome[128],
    ArenaCmd[32],
    Float:ax[3],
    Float:ay[3],
    Float:az[3],
    Float:aRot[3],
    ArenaInterior,
    ArenaArmas[14]
}
static const ArenasDM[][iAreas] =
{
    {"Minigun", "/minigun", {-975.975708,-1131.34},{1060.983032,1057.89},{1345.671875,1346.41}, {90.0,266.25}, 10, {38}},
    {"Combate AK-47", "/ak47", {2558.80, 2534.86,2545.04}, {-1283.43,-1286.54,-1303.41}, {1031.42,1031.42,1031.42}, {139.73,245.28,177.91}, 2, {30}}
    //{"1 HP", "/1hp",  {1064.838745,1529.081787,52.390094}, {1120.363281,1529.369750,52.411670}, {1120.363281,1529.369750,52.411670}, 120.0, 0, {24}}
//  {"Vulcão", 343.7978,362.5833,10.8930
};

static const FrasesRandomicas[][] =
{
    {"{48D1CC}Encontrou problemas no servidor? Relate-os para a administração para que seja solucionado."},
    {"{48D1CC}Não nos responsabilizamos por contas hackeadas, não use senhas iguais de outros servidores."},
    {"{48D1CC}Veja as novidades de nosso servidor usando /novidades."},
    {"{48D1CC}Você pode ouvir rádios online diretamente de nosso servidor, use /radios."},
    {"{48D1CC}Nós disponibilizamos coisas especiais em veículos, use /teclas e saiba mais."},
    {"{48D1CC}Mega Freeroam: Stunt, DM, Corridas, Drift, e outros! Obrigado por jogar em nosso servidor!"},
    {"{48D1CC}Suspeita que alguém use cheater em nosso servidor? Use /relato [id infrator] [justificativa] para que nossa administração resolva!"},
    {"{48D1CC}Não peça cargo em nosso servidor, você poderá ser banido."},
    {"{48D1CC}Não divulgue o nosso servidor, em outros servidores. Não queremos conflitos com outros servidores."}
};
new Frase_Randomica;
//new GangZones[9]; //IDs das GangZones.
static const CargosAdmin[][] =
{
    {"Civil"},
    {"Organizador"},
    {"Moderador"},
    {"Gerenciador"},
    {"Beta-Tester"},
    {"Desenvolvedor"}
};
static const AnimesComandos[][] = {
    "/push","/carkick", "/lowbodypush", "/spray", "/headbutt", "/medic", "/koface",
    "/kostomach", "/lifejump", "/cansado", "/leftslap", "/rolar", "/carlock", "/rcarjack1", "/lcarjack1",
    "/rcarjack2", "/lcarjack2", "/hoodfrisked", "/lightcig", "/calma", "/bat", "/box", "/lay2", "/chant",
    "/finger", "/gritar", "/cop", "/cutuvelada", "/kneekick", "/fstance", "/gpunch", "/airkick", "/gkick",
    "/lowthrow", "/highthrow", "/dealstance", "/dancar [1-4]", "/dj [1-4]", "/sup [1-3]", "/basket [1-6]",
    "/knife [1-4]", "/beijar", "/stop", "/punheta", "/handsup", "/ligar", "/desligar", "/bebado", "/bomba",
    "/apontar", "/merda", "/marcararse", "/roubar", "/cruzarb", "/deitar", "/abaixar", "/vomitar", "/comer",
    "/rap", "/passaramao", "/cobrar", "/oberdose", "/fumar", "/fumar2", "/sentar", "/conversar", "/fodase",
    "/taichi", "/observar"
};


enum iGang
{
	GangNome[128],
	GangDescricao[128],
	Lider, //ID da conta do Lider
	SubLider, //ID da conta do Sub-Lider
	GangCor,
	ID_MySQL,
	GangTag[5],
	GangMembros[MAX_GANG_MEMBROS],
	GangAreas[MAX_GANG_AREAS],
	bool:Valida
}
new Gangs[MAX_GANGS][iGang];



enum iArea
{
	AreaNome[128],
	AreaGang, //ID DA GANG
	Float:LocPos[4],
	Float:LocCentro[3],
	bool:Dominada,
	bool:EmAtaque,
	bool:Valida, //Pra checar se é existente ou não
	TempoAtaque,

	ID_MySQL,
	GangZoneID,
	AreaID,
	Text3D:AreaText
}
new Areas[MAX_AREAS][iArea];


/*
	Hooks (By NicK)
*/
stock Ex_GivePlayerMoney(playerid, money) {
	PlayerInfo[playerid][pDinheiro] += money;
	return GivePlayerMoney(playerid, money);
}
#if defined _ALS_GivePlayerMoney
	#undef GivePlayerMoney
#else
	#define _ALS_GivePlayerMoney
#endif
#define GivePlayerMoney Ex_GivePlayerMoney
stock Ex_CriarVeiculo(modelo, Float:x, Float:y, Float:z, Float:rot, cor1, cor2, respawnar) {
	new vid = CreateVehicle(modelo, x, y, z, rot, cor1, cor2, respawnar);
	if(vid == INVALID_VEHICLE_ID) return INVALID_VEHICLE_ID;
	SetVehicleNumberPlate(vid, "M. Freeroam");
	VehInfo[vid][vehModelo] = modelo;
	VehInfo[vid][vehCores][0] = cor1;
	VehInfo[vid][vehCores][1] = cor2;
	for(new i; i < 14; i++)
	    VehInfo[vid][vehComponentes][i] = 0;
	VehInfo[vid][NeonID] = 0;
	//VehInfo[vid][DonoID] = INVALID_PLAYER_ID;
	return vid;
}
#if defined _ALS_CreateVehicle
	#undef CreateVehicle
#else
	#define _ALS_CreateVehicle
#endif
#define CreateVehicle Ex_CriarVeiculo

stock Ex_CriarVeiculoEstatico(modelo, Float:x, Float:y, Float:z, Float:rot, cor1, cor2) {
	new vid = AddStaticVehicle(modelo, x, y, z, rot, cor1, cor2);
	if(vid == INVALID_VEHICLE_ID) return INVALID_VEHICLE_ID;
    SetVehicleNumberPlate(vid, "M. Freeroam");
	VehInfo[vid][vehModelo] = modelo;
	VehInfo[vid][vehCores][0] = cor1;
	VehInfo[vid][vehCores][1] = cor2;
	for(new i; i < 14; i++)
	    VehInfo[vid][vehComponentes][i] = 0;
	VehInfo[vid][NeonID] = 0;
	VehInfo[vid][DonoID] = INVALID_PLAYER_ID;
	return vid;
}
#if defined _ALS_AddStaticVehicle
	#undef AddStaticVehicle
#else
	#define _ALS_AddStaticVehicle
#endif
#define AddStaticVehicle Ex_CriarVeiculoEstatico

stock Ex_DestruirVeiculo(vid) {
	for(new i; i < 14; i++)
	    VehInfo[vid][vehComponentes][i] = 0;
	VehInfo[vid][vehModelo] = 0;
	VehInfo[vid][NeonID] = 0;
	for(new i; i < 2; i++)
		VehInfo[vid][vehCores][i] = 0;
	if(VehInfo[vid][NeonEsquerdo] != 0) {
		DestroyDynamicObject(VehInfo[vid][NeonEsquerdo]);
		DestroyDynamicObject(VehInfo[vid][NeonDireito]);
		VehInfo[vid][NeonEsquerdo] = 0;
		VehInfo[vid][NeonDireito] = 0;
	}
	/*if(VehInfo[vid][DonoID] != INVALID_PLAYER_ID) {
		new playerid = VehInfo[vid][DonoID];
		PlayerInfo[playerid][NeonID] = 0;
		PlayerInfo[playerid][VehModelo] = 0;
		PlayerInfo[playerid][VehPintura] = 0;
		for(new i; i < 14; i++)
		    PlayerInfo[playerid][VehComponentes][i] = 0;
		for(new i; i < 2; i++)
		    PlayerInfo[playerid][VehCores][i] = 0;
	}
	VehInfo[vid][DonoID] = INVALID_PLAYER_ID; */
	return DestroyVehicle(vid);
}
#if defined _ALS_DestroyVehicle
	#undef DestroyVehicle
#else
	#define _ALS_DestroyVehicle
#endif
#define DestroyVehicle Ex_DestruirVeiculo

stock Ex_AdicionarComponente(vid, componentid) {
	VehInfo[vid][vehComponentes][GetVehicleComponentType(componentid)] = componentid;
	if(VehInfo[vid][DonoID] != INVALID_PLAYER_ID)
	    PlayerInfo[VehInfo[vid][DonoID]][VehComponentes][GetVehicleComponentType(componentid)] = componentid;
	return AddVehicleComponent(vid, componentid);
}
#if defined _ALS_AddVehicleComponent
	#undef AddVehicleComponent
#else
	#define _ALS_AddVehicleComponent
#endif
#define AddVehicleComponent Ex_AdicionarComponente

stock Ex_RemoverComponente(vid, componentid) {
	VehInfo[vid][vehComponentes][GetVehicleComponentType(componentid)] = 0;
	if(VehInfo[vid][DonoID] != INVALID_PLAYER_ID)
	    PlayerInfo[VehInfo[vid][DonoID]][VehComponentes][GetVehicleComponentType(componentid)] = 0;
	return RemoveVehicleComponent(vid, componentid);
}
#if defined _ALS_RemoveVehicleComponent
	#undef RemoveVehicleComponent
#else
	#define _ALS_RemoveVehicleComponent
#endif
#define RemoveVehicleComponent Ex_RemoverComponente

stock Ex_ChangeVehicleColor(vid, cor1, cor2) {
	VehInfo[vid][vehCores][0] = cor1;
	VehInfo[vid][vehCores][1] = cor2;
	if(VehInfo[vid][DonoID] != INVALID_PLAYER_ID) {
		PlayerInfo[VehInfo[vid][DonoID]][VehCores][0] = cor1;
		PlayerInfo[VehInfo[vid][DonoID]][VehCores][1] = cor2;
	}
	return ChangeVehicleColor(vid, cor1, cor2);
}

#if defined _ALS_ChangeVehicleColor
	#undef ChangeVehicleColor
#else
	#define _ALS_ChangeVehicleColor
#endif
#define ChangeVehicleColor Ex_ChangeVehicleColor

stock Ex_SetPlayerPos(playerid, Float:x, Float:y, Float:z) {
	CallRemoteFunction("Drift_SetPos", "dfff", playerid, x, y, z);
	return Streamer_UpdateEx(playerid, x, y, z), SetPlayerPos(playerid, x, y, z);
}

#if defined _ALS_SetPlayerPos
	#undef SetPlayerPos
#else
	#define _ALS_SetPlayerPos
#endif
#define SetPlayerPos Ex_SetPlayerPos


/*
    Callbacks SA-MP e Outras (by NicK)
*/

//variáveis
new Count;

main()
{
	print("\n----------------------------------");
	print("Mega Freeroam - Stunt/DM/Drift/Race");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	AntiDeAMX();
    //MySQL
    mysql = mysql_connect(mysql_host, mysql_usuario, mysql_db, mysql_senha);
	if(mysql_errno(mysql)) return print("Problema de conexão no MySQL"), SendRconCommand("exit");
	print("MySQL conectado");
    UsePlayerPedAnims();
    //DisableInteriorEnterExits();
    ShowPlayerMarkers(1);
    ShowNameTags(1);
    EnableStuntBonusForAll(1);
	SetGameModeText("Brasil - Stunt/DM/Drift/Race");
    //Skins
    AddPlayerClass(29,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(2,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(96,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(30,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(23,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(169,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(170,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(15,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(20,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(59,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(163,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(147,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(82,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(188,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(76,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(45,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(100,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(101,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(91,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(137,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(66,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(60,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(72,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(191,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(117,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(192,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(184,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(264,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(179,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(261,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(115,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(193,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(126,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(270,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(173,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(194,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(289,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(273,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(250,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(299,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(248,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(230,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(240,  2000.71, 1522.77, 17.06, 179.80, 0, 0, 0, 0, 0, 0);

    //mSelection
    SKIN_LISTA = LoadModelSelectionMenu("skins.txt");
    ARMA_LISTA = LoadModelSelectionMenu("armas.txt");

    /* Text Draws Globais */
    Draws[0] = TextDrawCreate(565.000000, 80.000000, " ");
    TextDrawAlignment(Draws[0], 2);
    TextDrawBackgroundColor(Draws[0], 0x00000000);
    TextDrawFont(Draws[0], 5);
    TextDrawLetterSize(Draws[0], -0.949999, -12.100000);
    TextDrawColor(Draws[0], -1);
    TextDrawSetOutline(Draws[0], 0);
    TextDrawSetProportional(Draws[0], 1);
    TextDrawSetShadow(Draws[0], 0);
    TextDrawUseBox(Draws[0], 1);
    TextDrawBoxColor(Draws[0], 0);
    TextDrawTextSize(Draws[0], 54.000000, 68.000000);
    TextDrawSetPreviewModel(Draws[0], 415);
    TextDrawSetPreviewRot(Draws[0], -10.000000, -2.000000, 30.000000, 0.899999);
    TextDrawSetSelectable(Draws[0], 0);

    Draws[1] = TextDrawCreate(488.000000, 80.000000, " ");
    TextDrawAlignment(Draws[1], 2);
    TextDrawBackgroundColor(Draws[1], 0x00000000);
    TextDrawFont(Draws[1], 5);
    TextDrawLetterSize(Draws[1], -0.949999, -12.100000);
    TextDrawColor(Draws[1], -1);
    TextDrawSetOutline(Draws[1], 0);
    TextDrawSetProportional(Draws[1], 1);
    TextDrawSetShadow(Draws[1], 0);
    TextDrawUseBox(Draws[1], 1);
    TextDrawBoxColor(Draws[1], 0);
    TextDrawTextSize(Draws[1], 54.000000, 68.000000);
    TextDrawSetPreviewModel(Draws[1], 402);
    TextDrawSetPreviewRot(Draws[1], -10.000000, -2.000000, -20.000000, 0.899999);
    TextDrawSetSelectable(Draws[1], 0);

    Draws[2] = TextDrawCreate(523.000000, 80.000000, " ");
    TextDrawAlignment(Draws[2], 2);
    TextDrawBackgroundColor(Draws[2], 0x00000000);
    TextDrawFont(Draws[2], 5);
    TextDrawLetterSize(Draws[2], -0.949999, -12.100000);
    TextDrawColor(Draws[2], -1);
    TextDrawSetOutline(Draws[2], 0);
    TextDrawSetProportional(Draws[2], 1);
    TextDrawSetShadow(Draws[2], 0);
    TextDrawUseBox(Draws[2], 1);
    TextDrawBoxColor(Draws[2], 0);
    TextDrawTextSize(Draws[2], 54.000000, 68.000000);
    TextDrawSetPreviewModel(Draws[2], 411);
    TextDrawSetPreviewRot(Draws[2], -10.000000, -2.000000, 0.000000, 0.800000);
    TextDrawSetSelectable(Draws[2], 0);

    Draws[3] = TextDrawCreate(548.000000, 90.000000, " ");
    TextDrawAlignment(Draws[3], 2);
    TextDrawBackgroundColor(Draws[3], 0x00000000);
    TextDrawFont(Draws[3], 5);
    TextDrawLetterSize(Draws[3], -0.949999, -12.100000);
    TextDrawColor(Draws[3], -1);
    TextDrawSetOutline(Draws[3], 0);
    TextDrawSetProportional(Draws[3], 1);
    TextDrawSetShadow(Draws[3], 0);
    TextDrawUseBox(Draws[3], 1);
    TextDrawBoxColor(Draws[3], 0);
    TextDrawTextSize(Draws[3], 54.000000, 68.000000);
    TextDrawSetPreviewModel(Draws[3], 522);
    TextDrawSetPreviewRot(Draws[3], -10.000000, -2.000000, 15.000000, 1.100000);
    TextDrawSetSelectable(Draws[3], 0);

    Draws[4] = TextDrawCreate(499.000000, 90.000000, " ");
    TextDrawAlignment(Draws[4], 2);
    TextDrawBackgroundColor(Draws[4], 0x00000000);
    TextDrawFont(Draws[4], 5);
    TextDrawLetterSize(Draws[4], -0.949999, -12.100000);
    TextDrawColor(Draws[4], -1);
    TextDrawSetOutline(Draws[4], 0);
    TextDrawSetProportional(Draws[4], 1);
    TextDrawSetShadow(Draws[4], 0);
    TextDrawUseBox(Draws[4], 1);
    TextDrawBoxColor(Draws[4], 0);
    TextDrawTextSize(Draws[4], 54.000000, 68.000000);
    TextDrawSetPreviewModel(Draws[4], 522);
    TextDrawSetPreviewRot(Draws[4], -10.000000, -2.000000, -15.000000, 1.100000);
    TextDrawSetSelectable(Draws[4], 0);

    Draws[5] = TextDrawCreate(566.000000, 92.000000, ".");
    TextDrawAlignment(Draws[5], 2);
    TextDrawBackgroundColor(Draws[5], 255);
    TextDrawFont(Draws[5], 1);
    TextDrawLetterSize(Draws[5], 13.420015, 1.000000);
    TextDrawColor(Draws[5], -1);
    TextDrawSetOutline(Draws[5], 0);
    TextDrawSetProportional(Draws[5], 1);
    TextDrawSetShadow(Draws[5], 0);
    TextDrawSetSelectable(Draws[5], 0);

    Draws[6] = TextDrawCreate(557.000000, 97.000000, "Mega Freeroam");
    TextDrawAlignment(Draws[6], 2);
    TextDrawBackgroundColor(Draws[6], 255);
    TextDrawFont(Draws[6], 2);
    TextDrawLetterSize(Draws[6], 0.280000, 1.800000);
    TextDrawColor(Draws[6], -1);
    TextDrawSetOutline(Draws[6], 0);
    TextDrawSetProportional(Draws[6], 1);
    TextDrawSetShadow(Draws[6], 1);
    TextDrawSetSelectable(Draws[6], 0);

    Draws[7] = TextDrawCreate(551.000000, 21.000000, "--:--");
    TextDrawBackgroundColor(Draws[7], 255);
    TextDrawFont(Draws[7], 3);
    TextDrawLetterSize(Draws[7], 0.509999, 2.399999);
    TextDrawColor(Draws[7], -1);
    TextDrawSetOutline(Draws[7], 1);
    TextDrawSetProportional(Draws[7], 1);
    TextDrawSetSelectable(Draws[7], 0);

    Draws[8] = TextDrawCreate(615.000000, 109.000000, Versao);
    TextDrawBackgroundColor(Draws[8], 255);
    TextDrawFont(Draws[8], 2);
    TextDrawLetterSize(Draws[8], 0.220000, 1.200000);
    TextDrawColor(Draws[8], -1);
    TextDrawSetOutline(Draws[8], 0);
    TextDrawSetProportional(Draws[8], 1);
    TextDrawSetShadow(Draws[8], 1);
    TextDrawSetSelectable(Draws[8], 0);

    Draws[9] = TextDrawCreate(383.000000, 431.000000, "~b~/cmds ~w~- Comandos ~b~/teles ~w~- Teleportes ~b~/v ~w~- Veiculos");
    TextDrawAlignment(Draws[9], 2);
    TextDrawBackgroundColor(Draws[9], 255);
    TextDrawFont(Draws[9], 2);
    TextDrawLetterSize(Draws[9], 0.340000, 1.600000);
    TextDrawColor(Draws[9], -1);
    TextDrawSetOutline(Draws[9], 1);
    TextDrawSetProportional(Draws[9], 1);
    TextDrawUseBox(Draws[9], 1);
    TextDrawBoxColor(Draws[9], 16);
    TextDrawTextSize(Draws[9], 0.000000, 405.000000);
    TextDrawSetSelectable(Draws[9], 0);

    Draws[10] = TextDrawCreate(616.500000, 431.000000, "0/150");
    TextDrawAlignment(Draws[10], 2);
    TextDrawBackgroundColor(Draws[10], 255);
    TextDrawFont(Draws[10], 2);
    TextDrawLetterSize(Draws[10], 0.270000, 1.600000);
    TextDrawColor(Draws[10], -1);
    TextDrawSetOutline(Draws[10], 1);
    TextDrawSetProportional(Draws[10], 1);
    TextDrawUseBox(Draws[10], 1);
    TextDrawBoxColor(Draws[10], 16);
    TextDrawTextSize(Draws[10], 0.000000, 55.000000);
    TextDrawSetSelectable(Draws[10], 0);
    
	Draws[11] = TextDrawCreate(609.000000, 30.000000, ":--");
	TextDrawAlignment(Draws[11], 2);
	TextDrawBackgroundColor(Draws[11], 255);
	TextDrawFont(Draws[11], 3);
	TextDrawLetterSize(Draws[11], 0.270000, 1.200000);
	TextDrawColor(Draws[11], -1);
	TextDrawSetOutline(Draws[11], 1);
	TextDrawSetProportional(Draws[11], 1);
	TextDrawSetSelectable(Draws[11], 0);

    DrawAnuncio = TextDrawCreate(386.000000, 357.000000, " ");
    TextDrawAlignment(DrawAnuncio, 2);
    TextDrawBackgroundColor(DrawAnuncio, 255);
    TextDrawFont(DrawAnuncio, 1);
    TextDrawLetterSize(DrawAnuncio, 0.430000, 1.500000);
    TextDrawColor(DrawAnuncio, -1);
    TextDrawSetOutline(DrawAnuncio, 0);
    TextDrawSetProportional(DrawAnuncio, 1);
    TextDrawSetShadow(DrawAnuncio, 1);
    TextDrawUseBox(DrawAnuncio, 1);
    TextDrawBoxColor(DrawAnuncio, 0x00000000);
    TextDrawTextSize(DrawAnuncio, 0.000000, 472.000000);
    TextDrawSetSelectable(DrawAnuncio, 0);


    Contagem[DrawContagem] = TextDrawCreate(321.000000, 126.000000, " ");
    TextDrawAlignment(Contagem[DrawContagem], 2);
    TextDrawBackgroundColor(Contagem[DrawContagem], 255);
    TextDrawFont(Contagem[DrawContagem], 2);
    TextDrawLetterSize(Contagem[DrawContagem], 0.720000, 3.700001);
    TextDrawColor(Contagem[DrawContagem], -1);
    TextDrawSetOutline(Contagem[DrawContagem], 1);
    TextDrawSetProportional(Contagem[DrawContagem], 1);
    TextDrawSetSelectable(Contagem[DrawContagem], 0);

//    Mapas();
    Veiculos();
    SendRconCommand("reloadfs Objetos");
    SendRconCommand("reloadfs driftpoints"); // Implantado
    SetTimer("Global", 1000, true);
    SetTimer("Frases", 1000 * 60 * 5, true);
    SetTimer("CorridaAleatoria", 1000 * 60 * 5, true);
    
    CarregarGangs();
	CarregarAreas();
    for(new i; i < CountDynamicObjects(); i++) {
		if(!IsValidDynamicObject(i)) continue;
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, i, E_STREAMER_STREAM_DISTANCE, 300.0);
	}

    return 1;
}
stock CarregarGangs() {
	new Cache:G = mysql_query(mysql, "SELECT * FROM gangs", true);
	if(cache_num_rows(mysql) > 0) {
		new gangid, string[200];
		for(new i; i < cache_num_rows(mysql); i++)
		{
			gangid++;
			if(gangid >= MAX_GANGS) break;
			Gangs[gangid][ID_MySQL] = cache_get_field_content_int(i, "id", mysql);
			Gangs[gangid][Lider] = cache_get_field_content_int(i, "Lider", mysql);
			Gangs[gangid][SubLider] = cache_get_field_content_int(i, "SubLider", mysql);
			Gangs[gangid][GangCor] = cache_get_field_content_int(i, "Cor", mysql);
			cache_get_field_content(i, "Membros", string, mysql, sizeof(string));
			unformat(string, "p<,>a<i>["#MAX_GANG_MEMBROS"]", Gangs[gangid][GangMembros]);
			cache_get_field_content(i, "Areas", string, mysql, sizeof(string));
			unformat(string, "p<,>a<i>["#MAX_GANG_AREAS"]", Gangs[gangid][GangAreas]);
			cache_get_field_content(i, "Nome", Gangs[gangid][GangNome], mysql, 128);
			cache_get_field_content(i, "Descricao", Gangs[gangid][GangDescricao], mysql, 128);
			cache_get_field_content(i, "TAG", Gangs[gangid][GangTag], mysql, 5);
			Gangs[gangid][Valida] = true;
		}
		printf("%i gangs carregadas!", gangid);
	}
	cache_delete(G, mysql);
	return 1;
}

stock CarregarAreas() {
	new Cache:A = mysql_query(mysql, "SELECT * FROM areas", true);
	if(cache_num_rows(mysql) > 0) {
		new areaid, string[200];
		for(new i; i < cache_num_rows(mysql); i++) {
			areaid++;
			if(areaid >= MAX_AREAS) break;
			Areas[areaid][ID_MySQL] = cache_get_field_content_int(i, "id", mysql);
			Areas[areaid][AreaGang] = cache_get_field_content_int(i, "Gang", mysql);
			cache_get_field_content(i, "Nome", Areas[areaid][AreaNome], mysql, 128);
			cache_get_field_content(i, "Localizacao", string, mysql, 200);
			unformat(string, "p<,>a<f>[4]", Areas[areaid][LocPos]);
			cache_get_field_content(i, "Centro", string, mysql, 200);
			unformat(string, "p<,>a<f>[3]", Areas[areaid][LocCentro]);
			Areas[areaid][Dominada] = (Areas[areaid][AreaGang] == 0) ? (false) : (true);
			Areas[areaid][EmAtaque] = false;
			Areas[areaid][Valida] = true;
			Areas[areaid][GangZoneID] = GangZoneCreate(Areas[areaid][LocPos][0],Areas[areaid][LocPos][1],Areas[areaid][LocPos][2],Areas[areaid][LocPos][3]);
			GangZoneShowForAll(Areas[areaid][GangZoneID], (Areas[areaid][AreaGang] == 0) ? (COR_AREA) : (Gangs[Areas[areaid][AreaGang]][GangCor]));
			Areas[areaid][AreaID] = CreateDynamicRectangle(Areas[areaid][LocPos][0],Areas[areaid][LocPos][1],Areas[areaid][LocPos][2],Areas[areaid][LocPos][3]);
			if(Areas[areaid][Dominada] == true)
				format(string, 200, "Gang: %s\nDescrição: %s\nNome Área: %s", Gangs[Areas[areaid][AreaGang]][GangNome], Gangs[Areas[areaid][AreaGang]][GangDescricao],Areas[areaid][AreaNome]);
			else
			    format(string, 200, "Área Neutra");
			Areas[areaid][AreaText] = CreateDynamic3DTextLabel(string, (Areas[areaid][AreaGang] == 0) ? (COR_AREA) : (Gangs[Areas[areaid][AreaGang]][GangCor]), Areas[areaid][LocCentro][0], Areas[areaid][LocCentro][1], Areas[areaid][LocCentro][2], 20.0);
		}
		printf("%i areas carregadas!", areaid);
	}
	cache_delete(A, mysql);
	return 1;
}

public OnGameModeExit()
{
    mysql_close(mysql);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    if(PlayerInfo[playerid][pCameraConnect] == true) {
    	SetPlayerPos(playerid, -1858.5479,4468.7563,6.6136);
        SetPlayerFacingAngle(playerid, 15.0);
        InterpolateCameraPos(playerid, -1898.57, 4600.78, 14.78, -1860.41, 4472.30, 5.69, 10000, CAMERA_CUT);
        InterpolateCameraLookAt(playerid, -1849.26, 4431.16, 22.96, -1858.5479,4468.7563,6.6136, 12000, CAMERA_CUT);
        PlayerInfo[playerid][pCameraConnect] = false;
    	/*SetPlayerCameraPos(playerid, 1997.41, 1520.09, 17.06);
        SetPlayerCameraLookAt(playerid, 2000.71, 1522.77, 17.06, CAMERA_MOVE); */
    }
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
    if(PlayerInfo[playerid][Logado] == false) return false;
    new spawn = random(sizeof(SpawnLocais));
    SetSpawnInfo(playerid, NO_TEAM, GetPlayerSkin(playerid), SpawnLocais[spawn][0], SpawnLocais[spawn][1], SpawnLocais[spawn][2], SpawnLocais[spawn][3], 31, 99999, 26, 99999, 24, 99999);
    SpawnPlayer(playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
    new samp[50];
    GetPlayerVersion(playerid, samp, 50);
    if(!strcmp(samp, "unknown", true)) return BanEx(playerid, "bot unknown");

	SetPlayerColor(playerid, CorNome[random(sizeof(CorNome))]);
    GetPlayerName(playerid, PlayerInfo[playerid][pNome], MAX_PLAYER_NAME);

	new string[256], Serial[128], Cache:BanGPCI;
    gpci(playerid, Serial, sizeof(Serial));
	mysql_format(mysql, string, sizeof(string), "SELECT * FROM gpci WHERE Serial='%e' AND DesbanAuto > %i", Serial, gettime());
	BanGPCI = mysql_query(mysql, string, true);
	if(cache_num_rows(mysql) > 0) {
	    new Dialog[400], Motivo[128], NomeBan[24], DataBan[50], IPBan[16], Ignore[100], Ignore_List[200], bool:BanIgnorado = false, ID = cache_get_field_content_int(0, "ID", mysql);
	    cache_get_field_content(0, "Ignorar", Ignore_List, mysql);
	    cache_get_field_content(0, "Motivo", Motivo, mysql);
	    cache_get_field_content(0, "IP", IPBan, mysql);
	    cache_get_field_content(0, "Nome", NomeBan, mysql);
	    cache_get_field_content(0, "Data", DataBan,mysql);
	    if(strlen(Ignore_List) > 0) {
			unformat(Ignore_List, "p<,>a<i>[100]", Ignore);
			new Cache:PegarID, PlayerID;
			mysql_format(mysql, string, sizeof(string), "SELECT id FROM usuarios WHERE Nome='%s' LIMIT 1", PlayerInfo[playerid][pNome]);
			PegarID = mysql_query(mysql, string, true);
			if(cache_num_rows(mysql) > 0) {
			    PlayerID = cache_get_field_content_int(0, "id", mysql);
				for(new i; i < 100; i++) {
					if(Ignore[i] == 0) continue;
					if(Ignore[i] == PlayerID)
					{
						BanIgnorado = true;
						break;
					}
				}
			}
			cache_delete(PegarID, mysql);
		}
		if(BanIgnorado == false) {
		    format(Dialog,sizeof(Dialog), "Olá %s.\n\nInfelismente, você está banido pelo sistema de banimento por serial do servidor.\n\nID do Banimento: %i (Necessário)\nSerial: %s\nIP: %s\nUsuário banido: %s\nData do banimento: %s\nMotivo: %s\n\n",
	     		PlayerInfo[playerid][pNome], ID, Serial, IPBan, NomeBan, DataBan, Motivo);
			ShowPlayerDialog(playerid, DialogSemResposta, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Banido permanentemente!", Dialog, "Fechar", "");
		    cache_delete(BanGPCI, mysql);
			Kick(playerid);
			return 1;
		}
	}
	cache_delete(BanGPCI, mysql);

 	new ORM:ormid = orm_create("usuarios", mysql);
	
	orm_addvar_string(ormid, PlayerInfo[playerid][pNome], 24, "Nome");
	orm_addvar_string(ormid, PlayerInfo[playerid][pSenha], 50, "Senha");
   	orm_addvar_int(ormid, PlayerInfo[playerid][pMySQL_ID], "id");
   	orm_addvar_int(ormid, PlayerInfo[playerid][pLevel], "Level");
	orm_addvar_int(ormid, PlayerInfo[playerid][pMorreu], "Morreu");
	orm_addvar_int(ormid, PlayerInfo[playerid][pMatou], "Matou");
	orm_addvar_int(ormid, PlayerInfo[playerid][pDinheiro], "Dinheiro");
	orm_addvar_int(ormid, PlayerInfo[playerid][pScore], "Score");
	orm_addvar_int(ormid, PlayerInfo[playerid][pGold], "Gold");
	orm_addvar_int(ormid, PlayerInfo[playerid][pCorridas], "Corridas");
	orm_addvar_int(ormid, PlayerInfo[playerid][pDriftPontosTotal], "PontosDrift");
	orm_addvar_int(ormid, PlayerInfo[playerid][ModoDrift], "ModoDrift");
	orm_addvar_string(ormid, PlayerInfo[playerid][pRegistroDia], 50, "Registrado");
	orm_addvar_int(ormid, PlayerInfo[playerid][pUltimoLogin], "UltimoLogin");
   	orm_addvar_int(ormid, PlayerInfo[playerid][pTempoJogado], "TempoJogado");
   	orm_addvar_int(ormid, PlayerInfo[playerid][Teclas], "Teclas");
	orm_addvar_int(ormid, PlayerInfo[playerid][Mudo], "Mudo");
	orm_addvar_int(ormid, PlayerInfo[playerid][MostrarDano], "ExibirDano");
	orm_addvar_int(ormid, PlayerInfo[playerid][pGang], "Gang");
	//Salvamento de Veículo
	orm_addvar_int(ormid, PlayerInfo[playerid][VehModelo], "VeiculoModelo");
	orm_addvar_int(ormid, PlayerInfo[playerid][VehCores][0], "VeiculoCor1");
	orm_addvar_int(ormid, PlayerInfo[playerid][VehCores][1], "VeiculoCor2");
	orm_addvar_int(ormid, PlayerInfo[playerid][NeonID], "Neon");
	orm_addvar_int(ormid, PlayerInfo[playerid][VehPintura], "VeiculoPintura");
	orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][0], "Aerofolio");
	orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][1], "Capô");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][2], "Teto");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][3], "SaiasLaterais");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][4], "Farois");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][5], "Nitro");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][6], "Descarga");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][7], "Rodas");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][8], "Stereo");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][9], "Hidraulica");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][10], "SaiaDianteira");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][11], "SaiaTrazeira");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][12], "VentDireito");
    orm_addvar_int(ormid, PlayerInfo[playerid][VehComponentes][13], "VentEsquerdo");
	orm_setkey(ormid, "Nome");
	orm_select(ormid, "OnPlayerLogin", "d", playerid);
    PlayerInfo[playerid][OrmID] = ormid;
    SendClientMessage(playerid, -1, " ");
    SendClientMessage(playerid, -1, "{FFD700}Seja bem vindo ao Mega Freeroam. Escolha uma skin.");
    SendClientMessage(playerid, -1, "");
    PlayerInfo[playerid][Logado] = false;
    PlayerInfo[playerid][pDLevel] = 0;
    PlayerInfo[playerid][pFPS] = 0;

    // Text Draw de informações do Player.
    PlayerInfo[playerid][DrawInfo] = CreatePlayerTextDraw(playerid, 89.5000000, 427.000000, " ");
    PlayerTextDrawAlignment(playerid, PlayerInfo[playerid][DrawInfo], 2);
    PlayerTextDrawBackgroundColor(playerid, PlayerInfo[playerid][DrawInfo], 255);
    PlayerTextDrawFont(playerid, PlayerInfo[playerid][DrawInfo], 2);
    PlayerTextDrawLetterSize(playerid, PlayerInfo[playerid][DrawInfo], 0.170000, 1.100000);
    PlayerTextDrawColor(playerid, PlayerInfo[playerid][DrawInfo], -1);
    PlayerTextDrawSetOutline(playerid, PlayerInfo[playerid][DrawInfo], 0);
    PlayerTextDrawSetProportional(playerid, PlayerInfo[playerid][DrawInfo], 1);
    PlayerTextDrawSetShadow(playerid, PlayerInfo[playerid][DrawInfo], 0);
    PlayerTextDrawUseBox(playerid, PlayerInfo[playerid][DrawInfo], 1);
    PlayerTextDrawBoxColor(playerid, PlayerInfo[playerid][DrawInfo], 16);
    PlayerTextDrawTextSize(playerid, PlayerInfo[playerid][DrawInfo], 11.000000, 175.000000);
    PlayerTextDrawSetSelectable(playerid, PlayerInfo[playerid][DrawInfo], 0);

    PlayerInfo[playerid][InfoMatador][0] = CreatePlayerTextDraw(playerid,88.000000, 269.000000, "");
    PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][InfoMatador][0], 2);
    PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][InfoMatador][0], 255);
    PlayerTextDrawFont(playerid,PlayerInfo[playerid][InfoMatador][0], 1);
    PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][InfoMatador][0], 0.319999, 1.500000);
    PlayerTextDrawColor(playerid,PlayerInfo[playerid][InfoMatador][0], -16776961);
    PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][InfoMatador][0], 1);
    PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][InfoMatador][0], 1);
    PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][InfoMatador][0], 1);
    PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][InfoMatador][0], 48);
    PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][InfoMatador][0], 0.000000, 140.000000);
    PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][InfoMatador][0], 0);

    PlayerInfo[playerid][InfoMatador][1] = CreatePlayerTextDraw(playerid,88.000000, 287.000000, "");
    PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][InfoMatador][1], 2);
    PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][InfoMatador][1], 255);
    PlayerTextDrawFont(playerid,PlayerInfo[playerid][InfoMatador][1], 1);
    PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][InfoMatador][1], 0.319999, 1.299999);
    PlayerTextDrawColor(playerid,PlayerInfo[playerid][InfoMatador][1], -1);
    PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][InfoMatador][1], 0);
    PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][InfoMatador][1], 1);
    PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][InfoMatador][1], 0);
    PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][InfoMatador][1], 1);
    PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][InfoMatador][1], 32);
    PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][InfoMatador][1], -24.000000, 140.000000);
    PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][InfoMatador][1], 0);

    PlayerInfo[playerid][Velocimetro] = CreatePlayerTextDraw(playerid,598.000000, 411.000000, " ");
    PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][Velocimetro], 2);
    PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][Velocimetro], 255);
    PlayerTextDrawFont(playerid,PlayerInfo[playerid][Velocimetro], 3);
    PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][Velocimetro], 0.340000, 1.700000);
    PlayerTextDrawColor(playerid,PlayerInfo[playerid][Velocimetro], -1);
    PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][Velocimetro], 1);
    PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][Velocimetro], 1);
    PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][Velocimetro], 1);
    PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][Velocimetro], 16);
    PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][Velocimetro], 0.000000, 74.000000);
    PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][Velocimetro], 0);

    PlayerInfo[playerid][pCameraConnect] = true;

	for(new i; i < 11; i++)
	    PlayerInfo[playerid][DrawStatus][i] = PlayerText:INVALID_TEXT_DRAW;

	PlayerInfo[playerid][DriftDraw][0] = CreatePlayerTextDraw(playerid,592.000000, 384.000000, "~w~1000~n~X: ~g~1");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][DriftDraw][0], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DriftDraw][0], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DriftDraw][0], 3);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DriftDraw][0], 0.330000, 1.400000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DriftDraw][0], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DriftDraw][0], 1);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DriftDraw][0], 1);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DriftDraw][0], 0);

	PlayerInfo[playerid][DriftDraw][1] = CreatePlayerTextDraw(playerid,590.000000, 371.000000, "Drift");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][DriftDraw][1], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DriftDraw][1], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DriftDraw][1], 0);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DriftDraw][1], 0.549999, 1.300000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DriftDraw][1], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DriftDraw][1], 1);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DriftDraw][1], 1);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DriftDraw][1], 0);
	
	PlayerInfo[playerid][PlayerDano][0] = CreatePlayerTextDraw(playerid,165.000000, 355.000000, "dano");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][PlayerDano][0], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][PlayerDano][0], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][PlayerDano][0], 2);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][PlayerDano][0], 0.380000, 1.400000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][PlayerDano][0], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][PlayerDano][0], 1);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][PlayerDano][0], 1);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][PlayerDano][0], 0);

	PlayerInfo[playerid][PlayerDano][1] = CreatePlayerTextDraw(playerid,121.000000, 362.000000, "-Skin-");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][PlayerDano][1], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][PlayerDano][1], 0);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][PlayerDano][1], 5);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][PlayerDano][1], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][PlayerDano][1], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][PlayerDano][1], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][PlayerDano][1], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][PlayerDano][1], 1);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][PlayerDano][1], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][PlayerDano][1], 0);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][PlayerDano][1], 74.000000, 70.000000);
	PlayerTextDrawSetPreviewModel(playerid, PlayerInfo[playerid][PlayerDano][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, PlayerInfo[playerid][PlayerDano][1], -16.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][PlayerDano][1], 0);

	//Cabeça
	PlayerInfo[playerid][PlayerDano][2] = CreatePlayerTextDraw(playerid,158.000000, 365.000000, "_");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][PlayerDano][2], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][PlayerDano][2], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][PlayerDano][2], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][PlayerDano][2], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][PlayerDano][2], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][PlayerDano][2], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][PlayerDano][2], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][PlayerDano][2], 1);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][PlayerDano][2], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][PlayerDano][2], -16777120);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][PlayerDano][2], 10.000000, 4.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][PlayerDano][2], 0);

	//Tronco
	PlayerInfo[playerid][PlayerDano][3] = CreatePlayerTextDraw(playerid,159.000000, 378.000000, "_");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][PlayerDano][3], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][PlayerDano][3], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][PlayerDano][3], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][PlayerDano][3], 0.519999, 1.700000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][PlayerDano][3], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][PlayerDano][3], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][PlayerDano][3], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][PlayerDano][3], 1);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][PlayerDano][3], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][PlayerDano][3], -16777120);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][PlayerDano][3], 4.000000, 14.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][PlayerDano][3], 0);

	//Braço Esquerdo
	PlayerInfo[playerid][PlayerDano][4] = CreatePlayerTextDraw(playerid,167.000000, 385.000000, "_");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][PlayerDano][4], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][PlayerDano][4], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][PlayerDano][4], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][PlayerDano][4], 0.500000, 1.300000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][PlayerDano][4], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][PlayerDano][4], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][PlayerDano][4], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][PlayerDano][4], 1);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][PlayerDano][4], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][PlayerDano][4], -16777120);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][PlayerDano][4], -3.000000, 2.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][PlayerDano][4], 0);

	//Braço Direito
	PlayerInfo[playerid][PlayerDano][5] = CreatePlayerTextDraw(playerid,150.000000, 385.000000, "_");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][PlayerDano][5], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][PlayerDano][5], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][PlayerDano][5], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][PlayerDano][5], 0.500000, 1.300000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][PlayerDano][5], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][PlayerDano][5], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][PlayerDano][5], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][PlayerDano][5], 1);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][PlayerDano][5], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][PlayerDano][5], -16777120);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][PlayerDano][5], -3.000000, 2.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][PlayerDano][5], 0);

	//Minhas bolas
	PlayerInfo[playerid][PlayerDano][6] = CreatePlayerTextDraw(playerid,158.000000, 398.000000, "_");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][PlayerDano][6], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][PlayerDano][6], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][PlayerDano][6], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][PlayerDano][6], 0.500000, 0.299999);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][PlayerDano][6], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][PlayerDano][6], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][PlayerDano][6], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][PlayerDano][6], 1);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][PlayerDano][6], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][PlayerDano][6], -16777120);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][PlayerDano][6], -3.000000, 2.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][PlayerDano][6], 0);

	//Perna Esquerda
	PlayerInfo[playerid][PlayerDano][7] = CreatePlayerTextDraw(playerid,164.000000, 398.000000, "_");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][PlayerDano][7], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][PlayerDano][7], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][PlayerDano][7], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][PlayerDano][7], 0.500000, 2.799999);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][PlayerDano][7], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][PlayerDano][7], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][PlayerDano][7], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][PlayerDano][7], 1);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][PlayerDano][7], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][PlayerDano][7], -16777120);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][PlayerDano][7], -3.000000, 5.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][PlayerDano][7], 0);

	//Perna Direita
	PlayerInfo[playerid][PlayerDano][8] = CreatePlayerTextDraw(playerid,155.000000, 398.000000, "_");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][PlayerDano][8], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][PlayerDano][8], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][PlayerDano][8], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][PlayerDano][8], 0.500000, 2.799999);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][PlayerDano][8], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][PlayerDano][8], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][PlayerDano][8], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][PlayerDano][8], 1);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][PlayerDano][8], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][PlayerDano][8], -16777120);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][PlayerDano][8], -3.000000, 5.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][PlayerDano][8], 0);
	
	PlayerInfo[playerid][pEspiando] = INVALID_PLAYER_ID;

    //golf stunt
    RemoveBuildingForPlayer(playerid, 621, 1273.2578, 2727.6719, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 622, 1277.9219, 2736.6484, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 616, 1264.0703, 2776.8750, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 622, 1269.9375, 2782.9375, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 621, 1280.9297, 2787.8984, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 616, 1259.2813, 2844.4609, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 621, 1304.2578, 2731.8359, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 622, 1316.8828, 2860.0313, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 621, 1390.9531, 2823.7344, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 616, 1396.8906, 2825.1875, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 621, 1378.1406, 2847.3438, 9.8281, 0.25);
    RemoveBuildingForPlayer(playerid, 622, 1384.5000, 2848.6016, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 621, 1399.3359, 2840.8672, 9.8203, 0.25);
    RemoveBuildingForPlayer(playerid, 621, 1404.9063, 2830.7734, 9.8203, 0.25);

	return 1;
}
forward OnPlayerLogin(playerid);
public OnPlayerLogin(playerid) {
	new Dialog[500];
	switch(orm_errno(PlayerInfo[playerid][OrmID])) {
		case ERROR_OK: {
		    GivePlayerMoney(playerid, PlayerInfo[playerid][pDinheiro]);
			format(Dialog, sizeof(Dialog), "{ffffff}Bem vindo de volta {ff0000}%s{ffffff}, efetue login digitando sua senha abaixo:\n", PlayerInfo[playerid][pNome]);
			ShowPlayerDialog(playerid, DialogLogar, DIALOG_STYLE_PASSWORD, "{ff0000}# {ffffff}Login", Dialog, "Login", "Cancelar");
		}
		case ERROR_NO_DATA: {
			format(Dialog, sizeof(Dialog), "{ffffff}Olá {ff0000}%s{ffffff}, você não está registrado em nosso servidor.\nPor favor, digite uma senha abaixo para se registrar:", PlayerInfo[playerid][pNome]);
			ShowPlayerDialog(playerid, DialogRegistrar, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}Registro", Dialog, "Registrar", "Cancelar");
		}
	}
	orm_setkey(PlayerInfo[playerid][OrmID], "id");
	return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    if(PlayerInfo[playerid][Logado] == true) {
		SalvarConta(playerid);
        new Msg[144];
        format(Msg, sizeof(Msg), "{EE0000}%s (id: %i) saiu do servidor. %s", PlayerInfo[playerid][pNome], playerid, (reason == 1) ? ("") : ((reason == 0) ? ("[Perda de conexão]") : (reason == 2) ? ("[Kick/Ban]") : ("")));
        SendClientMessageToAll(-1, Msg);
    }
	for(new i; i < GetMaxPlayers(); i++)
	    if(IsPlayerConnected(i))
	        if(PlayerInfo[i][pEspiando] == playerid) {
				TogglePlayerSpectating(i, false);
				PlayerInfo[i][pEspiando] = INVALID_PLAYER_ID;
			}
	        
	orm_destroy(PlayerInfo[playerid][OrmID]);
    if(PlayerInfo[playerid][pVeh] != 0)
        DestroyVehicle(PlayerInfo[playerid][pVeh]);
    PlayerInfo[playerid][pSenha] = 0;
    PlayerInfo[playerid][pLevel] = 0;
    PlayerInfo[playerid][pScore] = 0;
    PlayerInfo[playerid][pDinheiro] = 0;
    PlayerInfo[playerid][pGold] = 0;
    PlayerInfo[playerid][pMatou] = 0;
    PlayerInfo[playerid][pMorreu] = 0;
    PlayerInfo[playerid][Logado] = false;
    PlayerInfo[playerid][pNome] = 0;
    PlayerInfo[playerid][pTempoJogado] = 0;
    PlayerInfo[playerid][pTempoLogado] = 0;
    PlayerInfo[playerid][pCorridas] = 0;
    if(PlayerInfo[playerid][EmCorrida] == true) {
		PlayerInfo[playerid][CorridaID] = 0;
	    PlayerInfo[playerid][pCorridaCheckpoint] = 0;
	    PlayerInfo[playerid][pCorridaPos] = 0;
		if(PlayerInfo[playerid][pCorridaVeh] != 0)
		{
			DestroyVehicle(PlayerInfo[playerid][pCorridaVeh]);
			PlayerInfo[playerid][pCorridaVeh] = 0;
		}
		PlayerInfo[playerid][EmCorrida] = false;
	}
    PlayerInfo[playerid][pDriftPontosTotal] = 0;
    PlayerInfo[playerid][VehModelo] = 0;
    for(new i; i < 2; i++)
        PlayerInfo[playerid][VehCores][i] = 0;
    for(new i; i < 14; i++)
        PlayerInfo[playerid][VehComponentes][i] = 0;
    PlayerInfo[playerid][pVeh] = 0;
    PlayerInfo[playerid][AFK] = false;
    PlayerInfo[playerid][Mudo] = 0;
    PlayerInfo[playerid][pEspiando] = INVALID_PLAYER_ID;
    PlayerInfo[playerid][pRelatoTempo] = 0;
    PlayerInfo[playerid][pErrosSenha] = 0;
    PlayerInfo[playerid][ArenaID] = 0;
    PlayerInfo[playerid][EmArena] = false;
    PlayerInfo[playerid][pBans] = 0;
    PlayerInfo[playerid][pTempoBan] = 0;
    PlayerInfo[playerid][pCameraConnect] = false;
	PlayerInfo[playerid][ModoDrift] = 0;
	PlayerInfo[playerid][pEmail] = 0;
	PlayerInfo[playerid][pUltimoLogin] = 0;
	PlayerInfo[playerid][pRegistroDia] = 0;
	PlayerInfo[playerid][Teclas] = false;
	PlayerInfo[playerid][pEspiando] = INVALID_PLAYER_ID;
	return 1;
}

public OnPlayerSpawn(playerid)
{
    SetPlayerHealth(playerid, 99999);
    SetTimerEx("SpawnKill", 5000, false, "d", playerid);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    PlayerInfo[playerid][Morrer] = false;
    PlayerTextDrawShow(playerid, PlayerInfo[playerid][DrawInfo]);
    for(new i; i < sizeof(Draws); i++)
        TextDrawShowForPlayer(playerid, Draws[i]);
    TextDrawShowForPlayer(playerid, DrawAnuncio);
    TextDrawShowForPlayer(playerid, Contagem[DrawContagem]);
    if(PlayerInfo[playerid][EmArena] == true) {
        new spawn = PlayerInfo[playerid][ArenaID];
        new sr = random(3);
        if(ArenasDM[spawn][ax][sr] == 0)
            sr = random(2);
        if(ArenasDM[spawn][ax][sr] == 0)
            sr = random(1);
        if(ArenasDM[spawn][ax][sr] == 0)
            sr = 0;

        SetPlayerPos(playerid, ArenasDM[spawn][ax][sr], ArenasDM[spawn][ay][sr], ArenasDM[spawn][az][sr]);
        SetPlayerFacingAngle(playerid, ArenasDM[spawn][aRot][sr]);
        SetPlayerInterior(playerid, ArenasDM[spawn][ArenaInterior]);
        ResetPlayerWeapons(playerid);
        for(new i; i < 14; i++)
            GivePlayerWeapon(playerid, ArenasDM[spawn][ArenaArmas][i], 99999);
        SendClientMessage(playerid, -1, "{B3EE3A}# Para sair da arena, use /sairarena.");
    }
    PlayerInfo[playerid][pCameraConnect] = true;
    if(PlayerInfo[playerid][MostrarDano] == true)
    {
		PlayerTextDrawSetPreviewModel(playerid, PlayerInfo[playerid][PlayerDano][1], GetPlayerSkin(playerid));
		for(new i; i < 2; i++)
		    PlayerTextDrawShow(playerid, PlayerInfo[playerid][PlayerDano][i]);
	}
	for(new i; i < MAX_AREAS; i++)
		if(Areas[i][Valida] == true)
			GangZoneShowForPlayer(playerid, Areas[i][GangZoneID], (Areas[i][AreaGang] == 0) ? (0x80808080) : (Gangs[Areas[i][AreaGang]][GangCor]));
 	return 1;
}


public OnPlayerDeath(playerid, killerid, reason)
{
	if(PlayerInfo[playerid][EmCorrida] == true) {
		DisablePlayerCheckpoint(playerid);
		DisablePlayerRaceCheckpoint(playerid);
		SetPlayerVirtualWorld(playerid, 0);
		if(GetPlayerVehicleID(playerid) != 0)
		    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
		if(PlayerInfo[playerid][pCorridaVeh] != 0)
		{
			DestroyVehicle(PlayerInfo[playerid][pCorridaVeh]);
			PlayerInfo[playerid][pCorridaVeh] = 0;
		}
		PlayerTextDrawDestroy(playerid, PlayerInfo[playerid][CorridaPosInfo]);
		PlayerInfo[playerid][pCorridaPos] = 0;
		for(new i; i < 4; i++)
			TextDrawHideForPlayer(playerid, Corridas[PlayerInfo[playerid][CorridaID]][CorridaDraws][i]);
		PlayerInfo[playerid][EmCorrida] = false;
		PlayerInfo[playerid][CorridaID] = 0;
	}
    PlayerInfo[playerid][pCameraConnect] = true;
    PlayerTextDrawHide(playerid, PlayerInfo[playerid][Velocimetro]);
    PlayerTextDrawHide(playerid, PlayerInfo[playerid][DrawInfo]);
    for(new i; i < sizeof(Draws); i++)
        TextDrawHideForPlayer(playerid, Draws[i]);
    new spawn = random(sizeof(SpawnLocais));
    SetSpawnInfo(playerid, NO_TEAM, GetPlayerSkin(playerid), SpawnLocais[spawn][0], SpawnLocais[spawn][1], SpawnLocais[spawn][2], SpawnLocais[spawn][3], 22, 9999, 28, 9999, 0, 0);
    if(PlayerInfo[playerid][Morrer] == true) return 1;
    PlayerInfo[playerid][pMorreu]++;
    if(killerid != INVALID_PLAYER_ID) {
        if(GetPVarInt(playerid, "fake_kill") > gettime()) return BanEx(playerid, "fake kill");
        if(killerid == playerid) return BanEx(playerid, "fake kill");
        SetPVarInt(playerid, "fake_kill", gettime() + 2);
        SendDeathMessage(killerid, playerid, reason);
        new Msg[144];
        if(PlayerInfo[playerid][pScore] > 0)
            PlayerInfo[playerid][pScore]--;
        PlayerInfo[killerid][pScore]++;
        PlayerInfo[killerid][pMatou]++;
        GivePlayerMoney(killerid, 1500);
        format(Msg, sizeof(Msg), "{a9c4e4}Você matou {ffffff}%s{a9c4e4} e ganhou +1 score e {00ff00}R${ffffff}1500", PlayerInfo[playerid][pNome]);
        SendClientMessage(killerid, -1, Msg);
        format(Msg, sizeof(Msg), "_~n~_~n~_~n~_~r~Voce foi morto ~n~por ~w~%s", PlayerInfo[killerid][pNome]);
        GameTextForPlayer(playerid, Msg, 5000, 6);
        SetPlayerMarkerForPlayer(playerid, killerid, 0xff0000ff);
        SetPlayerMarkerForPlayer(killerid, playerid, GetPlayerColor(playerid));
        TogglePlayerSpectating(playerid, true);
        PlayerSpectatePlayer(playerid, killerid);
        format(Msg, sizeof(Msg), "~w~Mortes: ~r~%i~n~~w~Matou: ~g~%i~n~~w~Scores: ~b~%i~n~~w~Golds: ~y~%i", PlayerInfo[killerid][pMorreu], PlayerInfo[killerid][pMatou], PlayerInfo[killerid][pScore], PlayerInfo[killerid][pGold]);
        PlayerTextDrawSetString(playerid, PlayerInfo[playerid][InfoMatador][1], Msg);
        PlayerTextDrawSetString(playerid, PlayerInfo[playerid][InfoMatador][0], PlayerInfo[killerid][pNome]);
        for(new i; i < 2; i++)
            PlayerTextDrawShow(playerid, PlayerInfo[playerid][InfoMatador][i]);
        SetTimerEx("TVMatador", 10000, false, "d", playerid);
        SalvarConta(killerid);
    }
    else
        GameTextForPlayer(playerid, "~r~se fodeu", 5000, 0);
    SalvarConta(playerid);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	SetVehicleNumberPlate(vehicleid, "M. Freeroam");
	for(new i; i < 14; i++) {
		if(VehInfo[vehicleid][vehComponentes][i] == 0) continue;
		AddVehicleComponent(vehicleid, VehInfo[vehicleid][vehComponentes][i]);
	}
	if(VehInfo[vehicleid][vehPintura] > 0) {
		ChangeVehiclePaintjob(vehicleid, VehInfo[vehicleid][vehPintura]-1);
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z)
{
	return 1;
}
public OnPlayerText(playerid, text[])
{
    if(PlayerInfo[playerid][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Você não pode falar nada no chat sem estar logado."), 0;
    if(PlayerInfo[playerid][Mudo] == 1) return SendClientMessage(playerid, -1, "{ff0000}Você está calado."), 0;
	new Msg[144];
    new pvar [128] ;
    if(Flooder[playerid] == 1)
    {
        SendClientMessage(playerid, -1, "{FF0000}[ERRO]{FFFFFF} Você está calado por 30 segundos e não pode usar o chat !");
        return 0;
    }
    IsFlooding[playerid]++;
    if(IsFlooding[playerid] >= 3)
    {
        new pegarnome[24], pegarmensagem[128];
        GetPlayerName(playerid, pegarnome, sizeof(pegarnome));
        IsFlooding[playerid] = 0;
        Flooder[playerid] = 1;
        SendClientMessage(playerid, -1, "{FF0000}[INFO]{FFFFFF} Você foi calado por 30 segundos. Motivo: Flood");
        format(pegarmensagem, 128, "{009D4F}%s foi calado por 30 segundos. Motivo: {00A058}Flood", pegarnome);
		SendClientMessageToAll(0xFFFFFFFF, pegarmensagem);
        SetTimerEx("LiberarChat", 30000, false, "i", playerid);
        return 0;
    }
    else
    {
        SetTimerEx("SemFlood", 2000, false, "i", playerid);
    }
	GetPVarString (playerid,"UltimoTexto",pvar,sizeof(pvar)) ;
	if(strlen(pvar)&&!strcmp(pvar,text)){
        SendClientMessage(playerid,0x00FFFFFF,"* Pare de repetir no chat!") ;
        return 0;
	}
	SetPVarString(playerid,"UltimoTexto",text ) ;
    if(text[0] == ';') {
        new Float:pT[3];
        GetPlayerPos(playerid, pT[0], pT[1], pT[2]);
        format(Msg, sizeof(Msg),"{6495ED}* [PRÓX] %s: %s", PlayerInfo[playerid][pNome], text[1]);
        for(new i; i <= GetMaxPlayers(); i++) {
            if(IsPlayerInRangeOfPoint(i, 30.0, pT[0], pT[1], pT[2]))
                SendClientMessage(i, -1, Msg);
        }
        return 0;
    }
    format(Msg, 144, "%i - {%06x}%s: {ffffff}%s", playerid, GetPlayerColor(playerid) >>> 8, PlayerInfo[playerid][pNome], text);
    SendClientMessageToAll(-1, Msg);
    SetPlayerChatBubble(playerid, text, 0xEEEED180, 30.0, 10000);
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
    switch(newstate)
    {
        case PLAYER_STATE_DRIVER, PLAYER_STATE_PASSENGER: PlayerTextDrawShow(playerid, PlayerInfo[playerid][Velocimetro]);
        case PLAYER_STATE_ONFOOT: PlayerTextDrawHide(playerid, PlayerInfo[playerid][Velocimetro]);
    }
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	if(PlayerInfo[playerid][EmCorrida] == true)
	{
		if(Corridas[PlayerInfo[playerid][CorridaID]][Iniciada] == true)
		{
			new Msg[144], Premio;
			DisablePlayerCheckpoint(playerid);
			DisablePlayerRaceCheckpoint(playerid);
   			PlayerInfo[playerid][pCorridaCheckpoint]++;
			Corridas[PlayerInfo[playerid][CorridaID]][CorridaPosicao][PlayerInfo[playerid][pCorridaCheckpoint]]++;
			PlayerInfo[playerid][pCorridaPos] = Corridas[PlayerInfo[playerid][CorridaID]][CorridaPosicao][PlayerInfo[playerid][pCorridaCheckpoint]];
			if(PlayerInfo[playerid][pCorridaCheckpoint] >= Corridas[PlayerInfo[playerid][CorridaID]][MaxCheckpoints])
			{
				PlayerInfo[playerid][pCorridas]++;
				if(PlayerInfo[playerid][pCorridaPos] <= 3)
					PlayerInfo[playerid][pScore]++;
				Premio = Corridas[PlayerInfo[playerid][CorridaID]][CorridaPremio] / PlayerInfo[playerid][pCorridaPos];
				format(Msg, 144, "{ffff00}[CORRIDA] %s chegou em %iº lugar na corrida e ganhou R$%i", PlayerInfo[playerid][pNome],PlayerInfo[playerid][pCorridaPos], Premio);
				SendClientMessageToAll(-1, Msg);
				GivePlayerMoney(playerid, Premio);
				if(PlayerInfo[playerid][pCorridaPos] == GetPlayersCorrida(PlayerInfo[playerid][CorridaID]))
				{
					new corridaid =PlayerInfo[playerid][CorridaID];
					for(new i; i <= GetMaxPlayers(); i++)
					{
						if(IsPlayerConnected(i) && PlayerInfo[i][CorridaID] == PlayerInfo[playerid][CorridaID])
						{
							if(GetPlayerVehicleID(i) != 0)
	    						SetVehicleVirtualWorld(GetPlayerVehicleID(i), 0);
							if(PlayerInfo[i][pCorridaVeh] != 0) {
								DestroyVehicle(PlayerInfo[i][pCorridaVeh]);
								PlayerInfo[i][pCorridaVeh] = 0;
							}
							SetPlayerVirtualWorld(i, 0);
							PlayerInfo[i][CorridaID] = 0;
							PlayerInfo[i][EmCorrida] = false;
							PlayerTextDrawDestroy(i, PlayerInfo[i][CorridaPosInfo]);
						}
					}
					format(Msg, 144, "{ffff00}[CORRIDA] * Corrida %s terminada!", Corridas[corridaid][CorridaNome]);
					SendClientMessageToAll(-1, Msg);
                    TerminarCorrida(corridaid);
				}
			}
			else
			{
				new c = PlayerInfo[playerid][CorridaID];
				new p = PlayerInfo[playerid][pCorridaCheckpoint];
				new t = Corridas[c][CorridaTipo];
				if(p+1 < Corridas[c][MaxCheckpoints])
				{
					SetPlayerRaceCheckpoint(playerid, (t == CORRIDA_TERRESTRE) ? (0) : (3), Corridas[c][CheckpointX][p],Corridas[c][CheckpointY][p],Corridas[c][CheckpointZ][p], Corridas[c][CheckpointX][p+1], Corridas[c][CheckpointY][p+1], Corridas[c][CheckpointZ][p+1], 25.0);
				}
				else
				{
					SetPlayerRaceCheckpoint(playerid, (t == CORRIDA_TERRESTRE) ? (1) : (4), Corridas[c][CheckpointX][p],Corridas[c][CheckpointY][p],Corridas[c][CheckpointZ][p]+5.0, Corridas[c][CheckpointX][p+1], Corridas[c][CheckpointY][p+1], Corridas[c][CheckpointZ][p+1], 40.0);
				}
                PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
			}
			return 1;
		}
	}
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	GivePlayerMoney(playerid, (-AVehicleModPrices[componentid - 1000]));
	VehInfo[vehicleid][vehComponentes][GetVehicleComponentType(componentid)] = componentid;
    if(vehicleid == PlayerInfo[playerid][pVeh])
        PlayerInfo[playerid][VehComponentes][GetVehicleComponentType(componentid)] = componentid;
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	VehInfo[vehicleid][vehPintura] = paintjobid+1;
	if(vehicleid == PlayerInfo[playerid][pVeh])
	    PlayerInfo[playerid][VehPintura] = paintjobid+1;
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	VehInfo[vehicleid][vehCores][0] = color1;
	VehInfo[vehicleid][vehCores][1] = color2;
	if(vehicleid == PlayerInfo[playerid][pVeh]) {
		PlayerInfo[playerid][VehCores][0] = color1;
		PlayerInfo[playerid][VehCores][1] = color2;
	}
	GivePlayerMoney(playerid, -100);
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(GetPlayerVehicleSeat(playerid) == 0 && PlayerInfo[playerid][Teclas] == true)
	{
   		if (PRESSED(KEY_CROUCH)) {
			new Float:Velocity[3];
			GetVehicleVelocity(GetPlayerVehicleID(playerid), Velocity[0], Velocity[1], Velocity[2]);
		    SetVehicleVelocity(GetPlayerVehicleID(playerid), Velocity[0], Velocity[1], Velocity[2]+0.2);
		}
		if (PRESSED(KEY_YES)) {
			new Float:Velocity[3], Float:zAng;
			GetVehicleZAngle( GetPlayerVehicleID( playerid ), zAng );
			SetVehicleZAngle( GetPlayerVehicleID( playerid ), zAng );
			GetVehicleVelocity(GetPlayerVehicleID(playerid), Velocity[0], Velocity[1], Velocity[2]);
		    SetVehicleVelocity(GetPlayerVehicleID(playerid), 0.0, 0.0, 0.1);
   		}
        if(PRESSED(KEY_NO)) {
			new Float:Velocity[3];
			GetVehicleVelocity(GetPlayerVehicleID(playerid), Velocity[0], Velocity[1], Velocity[2]);
            SetVehicleVelocity(GetPlayerVehicleID(playerid), Velocity[0]*1.8, Velocity[1]*1.8, Velocity[2]*1.8);
            GameTextForPlayer(playerid, "~r~Turbo~w~!~b~!~g~!~w~!", 5000, 4);
        }
    }
    if(GetPlayerVehicleSeat(playerid) == 0 && PRESSED(KEY_ACTION))
	{
		if(GetVehicleComponentInSlot(GetPlayerVehicleID(playerid), GetVehicleComponentType(1010)) == 1010)
		{
			RemoveVehicleComponent(GetPlayerVehicleID(playerid), 1010);
			AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
			GameTextForPlayer(playerid, "~b~Nitro~w~!", 5000, 4);
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
    SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
    /*ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerInfo[playerid][pDinheiro]);*/
	PlayerInfo[playerid][pDinheiro] = GetPlayerMoney(playerid);
    if(GetPlayerVehicleID(playerid) != 0){
        new v[50];
        format(v, sizeof(v), "%d Km/h", GetPlayerSpeed(playerid));
        PlayerTextDrawSetString(playerid, PlayerInfo[playerid][Velocimetro], v);
    }
    else
        PlayerTextDrawSetString(playerid, PlayerInfo[playerid][Velocimetro], "");
    new drunknew = GetPlayerDrunkLevel(playerid);
    if(drunknew < 100) return SetPlayerDrunkLevel(playerid, 2000);
    else
    {
        if (PlayerInfo[playerid][pDLevel] != drunknew)
        {
            new wfps = PlayerInfo[playerid][pDLevel] - drunknew;
            if ((wfps > 0) && (wfps < 200)) PlayerInfo[playerid][pFPS] = wfps;
            PlayerInfo[playerid][pDLevel] = drunknew;
        }
    }
	if(CallRemoteFunction("FazendoDrift", "d", playerid) == 1 && PlayerInfo[playerid][ModoDrift] == 1) {
		new str[128];
		format(str, sizeof(str), "~w~%i~n~X: ~g~%i", CallRemoteFunction("PontosFeitos", "d", playerid), CallRemoteFunction("BonusFeitos", "d", playerid));
		PlayerTextDrawSetString(playerid, PlayerInfo[playerid][DriftDraw][0], str);
		for(new i; i < 2; i++)
			PlayerTextDrawShow(playerid, PlayerInfo[playerid][DriftDraw][i]);
	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(issuerid == INVALID_PLAYER_ID) return 1;
	if(PlayerInfo[playerid][MostrarDano] == true)
	{
		switch(bodypart)
		{
		    case 3: PlayerTextDrawShow(playerid, PlayerInfo[playerid][PlayerDano][3]);
		    case 9: PlayerTextDrawShow(playerid, PlayerInfo[playerid][PlayerDano][2]);
		    case 4: PlayerTextDrawShow(playerid, PlayerInfo[playerid][PlayerDano][6]);
		    case 5: PlayerTextDrawShow(playerid, PlayerInfo[playerid][PlayerDano][4]);
		    case 6: PlayerTextDrawShow(playerid, PlayerInfo[playerid][PlayerDano][5]);
		    case 7: PlayerTextDrawShow(playerid, PlayerInfo[playerid][PlayerDano][7]);
		    case 8: PlayerTextDrawShow(playerid, PlayerInfo[playerid][PlayerDano][8]);
		    default: return 1;
		}
		SetPVarInt(playerid, "info_dano", gettime() + 10);
		SetTimerEx("TirarDrawDano", 10000, false, "d", playerid);
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid) {
		case DialogBansSeriais: {
			if(!response) return 1;
			new Cache:Seriais = mysql_query(mysql, "SELECT * FROM gpci ORDER BY ID DESC LIMIT 100", true);
			if(cache_num_rows(mysql) > 0 && (listitem < cache_num_rows(mysql))) {
				new ID = cache_get_field_content_int(listitem, "ID", mysql), Nome[24], DataBan[50], Motivo[128], Serial[128], Ip[16], Info[500];
				cache_get_field_content(listitem, "Nome", Nome, mysql, sizeof(Nome));
				cache_get_field_content(listitem, "Motivo", Motivo, mysql, sizeof(Motivo));
				cache_get_field_content(listitem, "Serial", Serial, mysql, sizeof(Serial));
				cache_get_field_content(listitem, "IP", Ip, mysql, sizeof(Ip));
				cache_get_field_content(listitem, "Data", DataBan, mysql, sizeof(DataBan));
				format(Info, sizeof(Info), "Informações do banimento id %i\n\nSerial: %s\nNome: %s\nIP: %s\nData: %s\nMotivo: %s\n\nUse o ID para remover um banimento por serial.", ID, Serial, Nome, Ip, DataBan, Motivo);
				ShowPlayerDialog(playerid, DialogSerialInfo, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Informações de Banimento", Info, "Ok", "");
			}
			else
				SendClientMessage(playerid, -1, "{ff0000}Nenhum banimento..");
			cache_delete(Seriais, mysql);
			return 1;
		}
		case DialogSerialInfo: return cmd_seriaisbans(playerid, "");
		case DialogCriarGang:
		{
			if(!response || strlen(inputtext) == 0) return 1;
			new gangid;
			for(gangid = 1; gangid < MAX_GANGS; gangid++)
			    if(Gangs[gangid][Valida] == false) break;
			if(gangid == MAX_GANGS) return SendClientMessage(playerid, -1, "{ff0000}Máximo de gangs atingido!");
			PlayerInfo[playerid][pGang] = gangid;
			Gangs[gangid][Valida] = true;
			format(Gangs[gangid][GangNome], 128, inputtext);
			Gangs[gangid][Lider] = PlayerInfo[playerid][pMySQL_ID];
			ShowPlayerDialog(playerid, DialogGangDescricao, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}MF - Descrição de sua gang!", "Digite a descrição de sua gang:", "Ok", "");
			return 1;
		}
		case DialogGangDescricao: {
			if(!response || strlen(inputtext) == 0) return ShowPlayerDialog(playerid, DialogGangDescricao, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}MF - Descrição de sua gang!", "Você não digitou a descrição!\nDigite a descrição de sua gang:", "Ok", "");
			format(Gangs[PlayerInfo[playerid][pGang]][GangDescricao], 128, inputtext);
			ShowPlayerDialog(playerid, DialogGangCor, DIALOG_STYLE_LIST, "{ff0000}# {ffffff}MF - Escolha a cor de sua gang:", "Verde\r\nAzul\r\nAmarelo\r\nRoxo\r\nRosa\r\nVermelho Escuro\r\nVerde Escuro\r\n{ffff00}Cor personalizada (hexadecimal)", "Escolher", "");
			return 1;
		}
		case DialogGangCor: {
			if(!response) return SendClientMessage(playerid, -1, "{ff0000}Você não pode cancelar agora, escolha uma cor!"), ShowPlayerDialog(playerid, DialogGangCor, DIALOG_STYLE_LIST, "{ff0000}# {ffffff}MF - Escolha a cor de sua gang:", "Verde\r\nAzul\r\nAmarelo\r\nRoxo\r\nRosa\r\nVermelho Escuro\r\nVerde Escuro\r\n{ffff00}Cor personalizada (hexadecimal)", "Escolher", "");
			switch(listitem)
			{
				case 1: Gangs[PlayerInfo[playerid][pGang]][GangCor] = 0x0000FF40; //Azul
				case 0: Gangs[PlayerInfo[playerid][pGang]][GangCor] = 0x00640040; //Verde
				case 2: Gangs[PlayerInfo[playerid][pGang]][GangCor] = 0xFFFF0040; //Amarelo
				case 3: Gangs[PlayerInfo[playerid][pGang]][GangCor] = 0xA020F040; //Roxo ui
				case 5: Gangs[PlayerInfo[playerid][pGang]][GangCor] = 0xB2222240; //Vermelho Escuro
				case 4: Gangs[PlayerInfo[playerid][pGang]][GangCor] = 0xFF69B440; //Rosa UI
				case 6: Gangs[PlayerInfo[playerid][pGang]][GangCor] = 0x228B2240;
				default: return ShowPlayerDialog(playerid, DialogGangCorP, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}MF - Digite a cor em hexadecimal", "Digite a cor abaixo:", "Ok","");
			}
			ShowPlayerDialog(playerid, DialogGangTerTAG, DIALOG_STYLE_MSGBOX, "{ff0000}# {FFFFFF}MF - TAG", "Você deseja criar uma TAG para sua Gang?", "Sim", "Não");
			return 1;
		}
		case DialogGangTerTAG: {
			if(!response) return CriarGang(PlayerInfo[playerid][pGang]);
			return ShowPlayerDialog(playerid, DialogGangTAG, DIALOG_STYLE_INPUT, "{ff0000}# {FFFFFF}MF - Digite a TAG!", "Digite a tag desejada!\nMáximo de letras: 5", "Ok", "");
		}
		case DialogGangTAG: {
			if(!response || strlen(inputtext) == 0 || strlen(inputtext) >= 5) return ShowPlayerDialog(playerid, DialogGangTAG, DIALOG_STYLE_INPUT, "{ff0000}# {FFFFFF}MF - Digite a TAG!", "Digite a tag desejada!\nMáximo de letras: 5", "Ok", "");
			format(Gangs[PlayerInfo[playerid][pGang]][GangTag], 5, inputtext);
			CriarGang(PlayerInfo[playerid][pGang]);
			SendClientMessage(playerid, -1, "{ffff00}Parabéns! Sua gang foi criada!");
			MenuGang(playerid);
			SalvarConta(playerid);
			return 1;
		}
		case DialogGangMenu: {
			if(!response) return 1;
			switch(listitem) {
				case 0: {
					if(Gangs[PlayerInfo[playerid][pGang]][SubLider] != 0) return SendClientMessage(playerid, -1, "{ff0000}A Gang já possui um Sub-Líder!"), MenuGang(playerid);
					ShowPlayerDialog(playerid, DialogGangAdcSubLider, DIALOG_STYLE_INPUT, "{00ff00}# {ffffff}Gang - Adicionar Sub-Lider:", "Digite o nome do jogador que você deseja adicionar como sub-líder!", "Adicionar", "Cancelar");
				}
				case 1: ShowPlayerDialog(playerid, DialogGangConvidarMembro, DIALOG_STYLE_INPUT, "{00ff00}# {ffffff}Gang - Convidar Membro", "Digite o nome do jogador que deseja convidar:", "Convidar", "Cancelar");
				case 2: MembrosGang(playerid);
				case 3: AreasGang(playerid);
				case 4: {
				    new Msg[200];
				    format(Msg, sizeof(Msg), "%s\nAdicione a nova descrição de sua gang!", Gangs[PlayerInfo[playerid][pGang]][GangDescricao]);
					ShowPlayerDialog(playerid, DialogGangEditarDescricao, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}Gang - Editar descrição:", Msg, "Editar", "Cancelar");
				}
				case 5: ShowPlayerDialog(playerid, DialogDeletarGang, DIALOG_STYLE_MSGBOX, "{ff0000}#{ffffff} Gang", "Você deseja mesmo deletar sua gang?", "Sim", "Não");
			}
			return 1;
		}
		case DialogGangAdcSubLider: {
			if(!response) return MenuGang(playerid);
			new Query[350], Cache:A, Msg[144];
			mysql_format(mysql, Query, sizeof(Query), "SELECT id FROM usuarios WHERE Nome='%e' AND Gang=0", inputtext);
			A = mysql_query(mysql, Query, true);
			if(cache_num_rows(mysql) > 0)
			{
			    new ID = cache_get_field_content_int(0, "id", mysql);
			    Gangs[PlayerInfo[playerid][pGang]][SubLider] = cache_get_field_content_int(0, "id", mysql);
			    format(Query, sizeof(Query), "UPDATE usuarios SET Gang=%i WHERE id=%i",PlayerInfo[playerid][pGang], ID);
			    mysql_query(mysql, Query, false);
			    
			    format(Query, sizeof(Query), "UPDATE gangs SET SubLider=%i WHERE id=%i", ID,Gangs[PlayerInfo[playerid][pGang]][ID_MySQL]);
			    mysql_query(mysql, Query, false);
			    
				format(Msg, 144, "{ffff00}Você adicionou o sub-lider %s a sua gang!", inputtext);
				SendClientMessage(playerid, -1, Msg);
				new pID;
				sscanf(inputtext, "u", pID);
				if(IsPlayerConnected(pID))
				{
					PlayerInfo[pID][pGang] = PlayerInfo[playerid][pGang];
					format(Msg, 144, "{ffff00}O jogador %s te pois como sub-lider da gang dele!", PlayerInfo[playerid][pNome]);
					SendClientMessage(pID, -1, Msg);
					SalvarConta(pID);
				}
			}
			else
			    SendClientMessage(playerid, -1, "{ff0000}Erro!");
			cache_delete(A, mysql);
			MenuGang(playerid);
			return 1;
		}
		case DialogGangConvidarMembro: {
			if(!response || strlen(inputtext) == 0) return MenuGang(playerid);
			new pID, Msg[144];
			sscanf(inputtext, "u", pID);
			if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!"), MenuGang(playerid);
			if(PlayerInfo[pID][pGang] != 0) return SendClientMessage(playerid, -1, "{ff0000}Este jogador já está em uma gang!"), MenuGang(playerid);
			if(PlayerInfo[pID][pConviteGang] != 0) return SendClientMessage(playerid, -1, "{ff0000}Este jogador já foi convidado por uma gang!"), MenuGang(playerid);
			PlayerInfo[pID][pConviteGang] = PlayerInfo[playerid][pGang];
			format(Msg, 144, "{ffff00}A Gang %s está lhe convidando para ser membro, use /aceitargang ou /recusargang!", Gangs[PlayerInfo[playerid][pGang]][GangNome]);
			SendClientMessage(pID, -1, Msg);
			format(Msg, 144, "{ffff00}Você convidou %s para sua gang!", PlayerInfo[pID][pNome]);
			SendClientMessage(playerid, -1, Msg);
			return 1;
		}
		case DialogGangEditarDescricao: {
			if(!response) return MenuGang(playerid);
			new Msg[144], Query[250];
			format(Msg, 144, "{ffff00}Descrição atualizada: %s", inputtext);
			SendClientMessage(playerid, -1, Msg);
			mysql_format(mysql, Query, sizeof(Query), "UPDATE gangs SET Descricao='%e' WHERE id=%i", inputtext, Gangs[PlayerInfo[playerid][pGang]][ID_MySQL]);
			mysql_query(mysql, Query, false);
			MenuGang(playerid);
			return 1;
		}
		case DialogDeletarGang: {
			if(!response) return MenuGang(playerid);
			new Query[128];
			format(Query, sizeof(Query), "DELETE FROM gangs WHERE id=%i", Gangs[PlayerInfo[playerid][pGang]][ID_MySQL]);
			mysql_query(mysql, Query, false);
			for(new iGang:i; i < iGang; ++i)
				Gangs[PlayerInfo[playerid][pGang]][i] = 0;
			Gangs[PlayerInfo[playerid][pGang]][Valida] = false;
			PlayerInfo[playerid][pGang] = 0;
			SendClientMessage(playerid, -1, "{ffff00}Gang deletada!");
			SalvarConta(playerid);
			return 1;
		}
		case DialogGangMembros: {
			if(!response) return MenuGang(playerid);
			new Membro = Gangs[PlayerInfo[playerid][pGang]][GangMembros][listitem];
			new Query[128], Nome[24], Cache:M, Msg[200];
			mysql_format(mysql, Query, sizeof(Query), "SELECT Nome FROM usuarios WHERE id=%i", Membro);
			M = mysql_query(mysql, Query, true);
			if(cache_num_rows(mysql) > 0) {
			    cache_get_field_content(0, "Nome", Nome, mysql, sizeof(Nome));
			    format(Msg, 200, "{a9c4e4}Você deseja demitir o membro {ffffff}%s{a9c4e4}?", Nome);
			    ShowPlayerDialog(playerid, DialogDemitirMembro, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Demitir membro", Msg, "Sim", "Não");
				SetPVarInt(playerid, "demitir_membro", Membro);
			}
			else {
				SendClientMessage(playerid, -1, "{ff0000}Erro!");
				MenuGang(playerid);
			}
			cache_delete(M, mysql);
			return 1;
		}
		case DialogDemitirMembro:
		{
			if(!response) return MembrosGang(playerid), DeletePVar(playerid, "demtir_membro");
			new Query[300], LM[200], bool:pOn = false, Membro = GetPVarInt(playerid, "demitir_membro");
			for(new i; i < MAX_GANG_MEMBROS; i++)
			    if(Gangs[PlayerInfo[playerid][pGang]][GangMembros][i] == Membro)
			    {
                    Gangs[PlayerInfo[playerid][pGang]][GangMembros][i] = 0;
                    break;
				}
			for(new i; i < MAX_GANG_MEMBROS; i++) {
			    if(Gangs[PlayerInfo[playerid][pGang]][GangMembros][i] == 0) continue;
			    format(LM, sizeof(LM), "%s%i,",LM, Gangs[PlayerInfo[playerid][pGang]][GangMembros][i]);
			}
			format(Query, sizeof(Query), "UPDATE gangs SET Membros='%s' WHERE id=%i", LM, Gangs[PlayerInfo[playerid][pGang]][ID_MySQL]);
			mysql_query(mysql, Query, false);
			unformat(LM, "p<,>a<i>["#MAX_GANG_MEMBROS"]",Gangs[PlayerInfo[playerid][pGang]][GangMembros]);
			for(new i; i <= GetMaxPlayers(); i++) {
				if(!IsPlayerConnected(i)) continue;
				if(PlayerInfo[i][pMySQL_ID] == Membro) {
					PlayerInfo[i][pGang] = 0;
					SalvarConta(i);
					SendClientMessage(i, -1, "{ff0000}Você foi demitido de sua gang!");
					pOn = true;
					break;
				}
			}
			if(pOn == false) {
				format(Query, sizeof(Query), "UPDATE usuarios SET Gang=0 WHERE id=%i", Membro);
				mysql_query(mysql, Query, false);
			}
			DeletePVar(playerid, "demitir_membro");
			SendClientMessage(playerid, -1, "{ffff00}Membro demitido da gang com sucesso!");
			MembrosGang(playerid);
			return 1;
		}
		case DialogGangAreas: {
			if(!response) return MenuGang(playerid);
			new A, areaid, List[200], Topo[128];
			for(new i; i < MAX_GANG_AREAS; i++) {
				if(Gangs[PlayerInfo[playerid][pGang]][GangAreas][i] == 0) continue;
				if(listitem == A) { areaid=Gangs[PlayerInfo[playerid][pGang]][GangAreas][i]; break; }
				A++;
			}
			format(Topo, 128, "{ff0000}# {ffffff}Área: %s", Areas[areaid][AreaNome]);
			strcat(List, "Alterar nome da área\r\nIr até a área\r\nDeixar área neutra\r\n");
			ShowPlayerDialog(playerid, DialogGangAreaOpcoes, DIALOG_STYLE_LIST, Topo, List, "Selecionar", "Cancelar");
			SetPVarInt(playerid, "gang_area", areaid);
			return 1;
		}
		case DialogGangAreaOpcoes:
		{
			if(!response) return AreasGang(playerid), DeletePVar(playerid, "gang_area");
			new areaid = GetPVarInt(playerid, "gang_area");
			switch(listitem) {
				case 0: /*Alterar nome da área */ShowPlayerDialog(playerid, DialogGangAreaEditNome, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}Alterar nome da área!", "Digite o novo nome da área:", "Pronto", "Cancelar");
				case 1: /*Ir até a área */SetPlayerPos(playerid, Areas[areaid][LocCentro][0],Areas[areaid][LocCentro][1],Areas[areaid][LocCentro][2]), DeletePVar(playerid, "gang_area");
				case 2: { //Deixar área neutra
				    new gangid = Areas[areaid][AreaGang], Query[200];
				    for(new i; i < MAX_GANG_AREAS; i++) {
						if(Gangs[gangid][GangAreas][i] == areaid) {
                            Gangs[gangid][GangAreas][i] = 0;
                            Areas[areaid][AreaGang] = 0;
                            break;
						}
					}
					UpdateDynamic3DTextLabelText(Areas[areaid][AreaText], COR_AREA, "Área Neutra");
					GangZoneShowForAll(Areas[areaid][GangZoneID], COR_AREA);
					format(Areas[areaid][AreaNome], 128, "");
					Areas[areaid][Dominada] = false;
					mysql_format(mysql, Query, sizeof(Query), "UPDATE areas SET Gang=0,Nome='' WHERE id=%i", Areas[areaid][ID_MySQL]);
					mysql_query(mysql, Query, false);
					new str[200];
					for(new i; i < MAX_GANG_AREAS; i++) {
						if(Gangs[gangid][GangAreas][i] == 0) continue;
						format(str, sizeof(str), "%s%i,", str,Gangs[gangid][GangAreas][i]);
					}
					mysql_format(mysql, Query, sizeof(Query), "UPDATE gangs SET Areas='%s' WHERE id=%i", str, Gangs[gangid][ID_MySQL]);
					mysql_query(mysql, Query, false);
					SendClientMessage(playerid, -1, "{ffff00}Agora esta área é uma área neutra!");
					DeletePVar(playerid, "gang_area");
				}
			}
			return 1;
		}
		case DialogGangAreaNome: {
			if(!response || strlen(inputtext) == 0) return 1;
			new areaid=GetPVarInt(playerid, "dominar_area"), string[200];
			format(Areas[areaid][AreaNome], 128, inputtext);
			format(string, 200, "Gang: %s\nDescrição: %s\nNome da área: %s\n",Gangs[Areas[areaid][AreaGang]][GangNome], Gangs[Areas[areaid][AreaGang]][GangDescricao], inputtext);
			UpdateDynamic3DTextLabelText(Areas[areaid][AreaText], Gangs[Areas[areaid][AreaGang]][GangCor], string);
			SendClientMessage(playerid, -1, "{ffff00}Nome da área atualizado!");
			mysql_format(mysql, string, sizeof(string), "UPDATE areas SET Nome='%e' WHERE id=%i", inputtext, Areas[areaid][ID_MySQL]);
			mysql_query(mysql, string, false);
			DeletePVar(playerid, "dominar_area");
			return 1;
		}
		case DialogGangAreaEditNome: {
			if(!response || strlen(inputtext) == 0) return 1;
			new areaid=GetPVarInt(playerid, "gang_area"), string[200];
			format(Areas[areaid][AreaNome], 128, inputtext);
			format(string, 200, "Gang: %s\nDescrição: %s\nNome da área: %s\n",Gangs[Areas[areaid][AreaGang]][GangNome], Gangs[Areas[areaid][AreaGang]][GangDescricao], inputtext);
			UpdateDynamic3DTextLabelText(Areas[areaid][AreaText], Gangs[Areas[areaid][AreaGang]][GangCor], string);
			SendClientMessage(playerid, -1, "{ffff00}Nome da área atualizado!");
			mysql_format(mysql, string, sizeof(string), "UPDATE areas SET Nome='%e' WHERE id=%i", inputtext, Areas[areaid][ID_MySQL]);
			mysql_query(mysql, string, false);
			DeletePVar(playerid, "gang_area");
			return 1;
		}
		case DialogGangs:
		{
			if(!response) return 1;
        	new Cache:G, Query[128], Info[300];
            format(Query, sizeof(Query), "SELECT * FROM gangs ORDER BY id DESC LIMIT %i,50", GetPVarInt(playerid, "pag_gangs"));
            G = mysql_query(mysql, Query, true);
            if(!cache_num_rows(mysql)) return cache_delete(G, mysql), SendClientMessage(playerid, -1, "{ff0000}Erro!"), DeletePVar(playerid, "pag_gangs");
            switch(listitem) {
                case 0..49: {
                    new Nome[128], ID[2], Cache:T, Li[24], Sub[24], Desc[128];
                    cache_get_field_content(listitem, "Nome", Nome, mysql, 128);
                    cache_get_field_content(listitem, "Descricao", Desc, mysql, 128);
                    ID[0] = cache_get_field_content_int(listitem, "Lider", mysql);
                    ID[1] = cache_get_field_content_int(listitem, "SubLider", mysql);
                    format(Query, sizeof(Query), "SELECT Nome FROM usuarios WHERE ID=%i", ID[0]);
                    T = mysql_query(mysql, Query, true);
                    if(cache_num_rows(mysql) > 0)
                        cache_get_field_content(0, "Nome", Li, mysql, 24);
                    cache_delete(T, mysql);
                    format(Query, sizeof(Query), "SELECT Nome FROM usuarios WHERE ID=%i", ID[1]);
                    T = mysql_query(mysql, Query, true);
                    if(cache_num_rows(mysql) > 0)
                        cache_get_field_content(0, "Nome", Sub, mysql, 24);
                    cache_delete(T, mysql);
                    format(Info, sizeof(Info), "Informações da Gang: %s\nDescrição: %s\n\nLíder: %s\nSub Líder: %s\n", Nome, Desc, Li, Sub);
                    ShowPlayerDialog(playerid, DialogInfoGang, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Info Gang", Info, "Ok", "");
                }
                default: {
                    SetPVarInt(playerid, "pag_gangs", (GetPVarInt(playerid, "pag_gangs") + 50));
                    TodasGangs(playerid);
                }
            }
            cache_delete(G, mysql);
			return 1;
		}
		case DialogInfoGang: return TodasGangs(playerid);
        case DialogRegistrar: {
            if(!response) return KickMsg(playerid, "Kickado por não querer se registrar!");
            if(strlen(inputtext) < 4) return SendClientMessage(playerid, -1, "{ff0000}Mínimo de caracteres é 4, tente novamente."), RegistroDialog(playerid, "{ff0000}Ponha uma senha com mais de 4 caracteres.");
            if(strlen(inputtext) > 50) return SendClientMessage(playerid, -1, "{ff0000}Máximo de caracteres é 50. Tente novamente!"), RegistroDialog(playerid, "{ff0000}Ponha uma senha com menos de 50 caracteres.");
            PlayerInfo[playerid][Logado] = true;
            new Msg[144]; //query[256];
            format(Msg, 144, "{ffff00}Obrigado por se registrar em nosso servidor {ffffff}%s{ffff00}!", PlayerInfo[playerid][pNome]);
            SendClientMessage(playerid, -1, Msg);
			format(PlayerInfo[playerid][pSenha], 50, Encriptar(inputtext));
			PlayerInfo[playerid][pUltimoLogin] = gettime();
			new Dia, Mes, Ano, Horas, Min;
			getdate(Ano, Mes, Dia);
			gettime(Horas, Min);
			format(PlayerInfo[playerid][pRegistroDia], 50, "%02d/%02d/%d %02d:%02d", Dia, Mes, Ano, Horas, Min);
            orm_insert(PlayerInfo[playerid][OrmID]);
            format(Msg, sizeof(Msg), "{FF8C00}%s (id: %i) se registrou no servidor. [%i/%i]", PlayerInfo[playerid][pNome], playerid, GetPlayers(), GetMaxPlayers());
            SendClientMessageToAll(-1, Msg);
            PlayerInfo[playerid][pErrosSenha] = 0;
            return 1;
        }
        case DialogLogar: {
            if(!response) return KickMsg(playerid, "Kickado por não logar.");
            new Msg[144];
            if(strlen(inputtext) <= 1) {
                if(PlayerInfo[playerid][pErrosSenha] > 3) return SendClientMessage(playerid, -1, "{EECFA1}Lamentamos, esgotou-se as tentativas para login.");
                SendClientMessage(playerid, -1, "{ff0000}Você precisa digitar uma senha!");
                PlayerInfo[playerid][pErrosSenha]++;
                format(Msg, 144, "{ff0000}Você tem ainda {ffffff}%i{ff0000} tentativas para logar.", (3 - PlayerInfo[playerid][pErrosSenha]));
                LoginDialog(playerid, Msg);
                return 1;
            }
            if(strcmp(Descriptar(PlayerInfo[playerid][pSenha]), inputtext, false) != 0) {
                if(PlayerInfo[playerid][pErrosSenha] > 3) {
					if(strlen(PlayerInfo[playerid][pEmail]) > 3) {
						//
					}
				 	KickMsg(playerid, "{ff0000}Você não conseguiu logar com sucesso em nosso servidor.");
					return 1;
				}
				SendClientMessage(playerid, -1, "{ff0000}Senha incorreta!");
                PlayerInfo[playerid][pErrosSenha]++;
                format(Msg, 144, "{ff0000}Você tem ainda {ffffff}%i {ff0000}tentativas para logar.", (3 - PlayerInfo[playerid][pErrosSenha]));
                LoginDialog(playerid, Msg);
                return 1;
            }
			//Login
			PlayerInfo[playerid][pTempoLogado] = gettime();
		    PlayerInfo[playerid][Logado] = true;
            new tempoUltimoLogin = gettime() - PlayerInfo[playerid][pUltimoLogin], strUT[20];
			if(tempoUltimoLogin > (60*60*24)) {
				tempoUltimoLogin = tempoUltimoLogin / (60*60*24);
				format(strUT, sizeof(strUT), "%i dia%s", tempoUltimoLogin, (tempoUltimoLogin > 1) ? ("s") : (""));
			}
			else if(tempoUltimoLogin > (60*60)) {
				tempoUltimoLogin = tempoUltimoLogin / (60*60);
				format(strUT, sizeof(strUT), "%i hora%s", tempoUltimoLogin, (tempoUltimoLogin > 1) ? ("s") : (""));
			}
			else if(tempoUltimoLogin > 60) {
				tempoUltimoLogin = tempoUltimoLogin / 60;
				format(strUT, sizeof(strUT), "%i minuto%s", tempoUltimoLogin, (tempoUltimoLogin > 1) ? ("s") : (""));
			}
			else
			    format(strUT, sizeof(strUT), "%i segundo%s", tempoUltimoLogin, (tempoUltimoLogin > 1) ? ("s") : (""));
            format(Msg, 144, "{ffff00}Logado com sucesso {ffffff}%s{ffff00}! Ultimo login feito á %s!", PlayerInfo[playerid][pNome], strUT);
            SendClientMessage(playerid, -1, Msg);
            format(Msg, sizeof(Msg), "{FF8C00}%s (id: %i) conectou-se no servidor. [%i/%i]", PlayerInfo[playerid][pNome], playerid, GetPlayers(), GetMaxPlayers());
            SendClientMessageToAll(-1, Msg);
            PlayerInfo[playerid][pErrosSenha] = 0;
			PlayerInfo[playerid][pUltimoLogin] = gettime();
            return 1;
        }
        case DialogCorridas: {
			if(!response) return 1;
			new Msg[300], Cache:TCorridas = mysql_query(mysql, "SELECT * FROM corridas ORDER BY ID DESC", true);
			if(cache_num_rows(mysql) > 0 && listitem < cache_num_rows(mysql)) {
			    new Nome[128];
			    SetPVarInt(playerid, "corrida_id", cache_get_field_content_int(listitem, "ID", mysql));
				cache_get_field_content(listitem, "CorridaNome", Nome, mysql, 128);
				format(Msg, 300, "{0000ff}# {ffffff}%s", Nome);
				ShowPlayerDialog(playerid, DialogMenuCorrida, DIALOG_STYLE_LIST, Msg, "Carregar corrida\r\nEditar nome da corrida\r\nEditar prêmio da corrida\r\nEditar veículo da corrida\r\nEditar máximo de participantes\r\nAlterar tipo de corrida\r\n{ffff00}Apagar corrida", "Selecionar", "Cancelar");
			}
			else
			    SendClientMessage(playerid, -1, "{ff0000}* Erro! Não foi possível ver as corridas criadas! :/");
			cache_delete(TCorridas, mysql);
			return 1;
		}
		case DialogMenuCorrida: {
			if(!response) return DeletePVar(playerid, "corrida_id");
			new Msg[300], Query[300], Cache:ECorrida;
			switch(listitem) {
				case 0: {//Carregar corrida
				    format(Query, sizeof(Query), "SELECT * FROM corridas WHERE ID=%i", GetPVarInt(playerid, "corrida_id"));
				    mysql_tquery(mysql, Query, "MySQL_CarregarCorrida", "");
				    DeletePVar(playerid, "corrida_id");
				    SendClientMessage(playerid, -1, "{ffff00}* Corrida carregada!");
				}
				case 1: {//Editar nome
					format(Query, sizeof(Query), "SELECT CorridaNome FROM corridas WHERE ID=%i", GetPVarInt(playerid, "corrida_id"));
					ECorrida = mysql_query(mysql, Query, true);
					if(cache_num_rows(mysql) > 0) {
						new Nome[128]; cache_get_field_content(0, "CorridaNome", Nome, mysql, 128);
						format(Msg, sizeof(Msg), "Nome atual da corrida: %s\nDigite o novo nome desejado abaixo:",Nome);
						ShowPlayerDialog(playerid, DialogEditCorridaNome, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}Editar nome da corrida", Msg, "Editar", "Cancelar");
					}
					cache_delete(ECorrida, mysql);
				}
				case 2: { //Editar prêmio
				    format(Query, sizeof(Query), "SELECT CorridaPremio FROM corridas WHERE ID=%i", GetPVarInt(playerid, "corrida_id"));
				    ECorrida = mysql_query(mysql, Query, true);
				    if(cache_num_rows(mysql) > 0) {
				        format(Msg, sizeof(Msg), "Prêmio atual da corrida: R$%i\nDigite o valor desejado abaixo:", cache_get_field_content_int(0, "CorridaPremio", mysql));
				        ShowPlayerDialog(playerid, DialogEditCorridaPremio, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}Editar prêmio da corrida", Msg, "Editar", "Cancelar");
				    }
				    cache_delete(ECorrida, mysql);
				}
				case 3: { //Editar veiculo
				    format(Query, sizeof(Query), "SELECT Veiculo FROM corridas WHERE ID=%i", GetPVarInt(playerid, "corrida_id"));
				    ECorrida = mysql_query(mysql, Query, true);
				    if(cache_num_rows(mysql) > 0) {
						format(Msg, sizeof(Msg), "Modelo do veículo da corrida: %i %s\nDigite o ID do Veículo desejado:", cache_get_field_content_int(0, "Veiculo", mysql), (cache_get_field_content_int(0, "Veiculo", mysql) == 0) ? ("(Nenhum)") : (NomesVeiculos[cache_get_field_content_int(0, "Veiculo", mysql)-400]));
						ShowPlayerDialog(playerid, DialogEditCorridaVeiculo, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}Editar veículo da corrida", Msg, "Editar", "Cancelar");
					}
                    cache_delete(ECorrida, mysql);
				}
				case 4: { //Editar máximo de participantes
				    format(Query, sizeof(Query), "SELECT MaximoParticipantes FROM corridas WHERE ID=%i", GetPVarInt(playerid, "corrida_id"));
				    ECorrida = mysql_query(mysql, Query, true);
				    if(cache_num_rows(mysql) > 0) {
						format(Msg, sizeof(Msg), "Número máximo de participantes: %i\nDigite abaixo o valor desejado:", cache_get_field_content_int(0, "MaximoParticipantes", mysql));
						ShowPlayerDialog(playerid, DialogEditCorridaMaxPlayers, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}Editar máximo de participantes", Msg, "Editar", "Cancelar");
					}
				    cache_delete(ECorrida, mysql);
				}
				case 5: {   //Alterar TIPO
				    format(Query, sizeof(Query), "SELECT CorridaTipo FROM corridas WHERE ID=%i", GetPVarInt(playerid, "corrida_id"));
				    ECorrida = mysql_query(mysql, Query, true);
				    if(cache_num_rows(mysql) > 0) {
				        format(Msg, sizeof(Msg), "{ff0000}# {ffffff}Alterar tipo (Atual: %s)", (cache_get_field_content_int(0, "CorridaTipo", mysql) == CORRIDA_TERRESTRE) ? ("Terrestre") : ("Aérea"));
						ShowPlayerDialog(playerid, DialogEditCorridaTipo, DIALOG_STYLE_LIST, Msg, "Terrestre\r\nAérea\r\n", "Selecionar", "Cancelar");
					}
					cache_delete(ECorrida, mysql);
				}
				case 6: { //Apagar
				    format(Query, sizeof(Query), "DELETE FROM corridas WHERE ID=%i", GetPVarInt(playerid, "corrida_id"));
				    mysql_query(mysql, Query, false);
					DeletePVar(playerid, "corrida_id");
					SendClientMessage(playerid, -1, "{ffff00}* Corrida apagada!");
					cmd_carregarcorrida(playerid, "");
				}
			}
			return 1;
		}
		case DialogEditCorridaNome: {
		    if(!response || strlen(inputtext) == 0) return DeletePVar(playerid, "corrida_id"), cmd_carregarcorrida(playerid, "");
			new Query[300], Msg[144];
			mysql_format(mysql, Query, sizeof(Query), "UPDATE contas SET CorridaNome='%e' WHERE ID=%i", inputtext, GetPVarInt(playerid, "corrida_id"));
			mysql_query(mysql, Query, false);
			format(Msg, sizeof(Msg), "{ffff00}* Nome da corrida atualizado para %s", inputtext);
			SendClientMessage(playerid, -1, Msg);
			DeletePVar(playerid, "corrida_id");
   			return 1;
		}
		case DialogEditCorridaPremio: {
		    if(!response || strlen(inputtext) == 0) return DeletePVar(playerid, "corrida_id"), cmd_carregarcorrida(playerid, "");
			new Query[300], Msg[144];
			mysql_format(mysql, Query, sizeof(Query), "UPDATE contas SET CorridaPremio=%i WHERE ID=%i", strval(inputtext), GetPVarInt(playerid, "corrida_id"));
			mysql_query(mysql, Query, false);
			format(Msg, sizeof(Msg), "{ffff00}* Prêmio da corrida atualizado para R$%i", strval(inputtext));
			SendClientMessage(playerid, -1, Msg);
			DeletePVar(playerid, "corrida_id");
		    return 1;
		}
		case DialogEditCorridaMaxPlayers: {
		    if(!response || strlen(inputtext) == 0) return DeletePVar(playerid, "corrida_id"), cmd_carregarcorrida(playerid, "");
			new Query[300], Msg[144];
			mysql_format(mysql, Query, sizeof(Query), "UPDATE contas SET MaximoParticipantes=%i WHERE ID=%i", strval(inputtext), GetPVarInt(playerid, "corrida_id"));
			mysql_query(mysql, Query, false);
			format(Msg, sizeof(Msg), "{ffff00}* Máximo de participantes da corrida atualizado para %i", strval(inputtext));
			SendClientMessage(playerid, -1, Msg);
			DeletePVar(playerid, "corrida_id");
		    return 1;
		}
		case DialogEditCorridaVeiculo: {
		    if(!response || strlen(inputtext) == 0) return DeletePVar(playerid, "corrida_id"), cmd_carregarcorrida(playerid, "");
			new Query[300], Msg[144];
			mysql_format(mysql, Query, sizeof(Query), "UPDATE contas SET Veiculo=%i WHERE ID=%i", strval(inputtext), GetPVarInt(playerid, "corrida_id"));
			mysql_query(mysql, Query, false);
			format(Msg, sizeof(Msg), "{ffff00}* Veiculo da corrida atualizado para %i (%s)", strval(inputtext), (strval(inputtext) == 0) ? ("Nenhum") : (NomesVeiculos[strval(inputtext)-400]));
			SendClientMessage(playerid, -1, Msg);
			DeletePVar(playerid, "corrida_id");
		    return 1;
		}
		case DialogEditCorridaTipo: {
			if(!response) return DeletePVar(playerid, "corrida_id"), cmd_carregarcorrida(playerid, "");
			new Query[300], Msg[144], Tipo;
			switch(listitem) {
				case 0: Tipo = CORRIDA_TERRESTRE;
				case 1: Tipo = CORRIDA_AEREA;
			}
			format(Query, sizeof(Query), "UPDATE contas SET CorridaTipo=%i WHERE ID=%i", Tipo, GetPVarInt(playerid, "corrida_id"));
			mysql_query(mysql, Query, false);
			format(Msg, sizeof(Msg), "{ffff00}* Tipo de corrida alterado para: %s", (Tipo == CORRIDA_TERRESTRE) ? ("Terrestre") : ("Aerea"));
			SendClientMessage(playerid, -1, Msg);
			DeletePVar(playerid, "corrida_id");
			return 1;
		}
        case DialogVeiculoClasse: {
            if(!response) return 1;
            new Classe = listitem + 1;
            new nomeClasse[100], veiculos[sizeof(ClasseVeiculo)];
            switch(Classe) {
                case ClasseMotos: format(nomeClasse, sizeof(nomeClasse), "Motos");
                case ClasseBarco: format(nomeClasse, sizeof(nomeClasse), "Barcos");
                case ClasseConversivel: format(nomeClasse, sizeof(nomeClasse), "Conversiveis");
                case ClasseHelicoptero: format(nomeClasse, sizeof(nomeClasse), "Helicopteros");
                case ClasseIndustrial: format(nomeClasse, sizeof(nomeClasse), "Industriais");
                case ClasseLowRider: format(nomeClasse, sizeof(nomeClasse), "Low-Rider's");
                case ClasseOffRoad: format(nomeClasse, sizeof(nomeClasse), "Off-Road");
                case ClasseAviao: format(nomeClasse, sizeof(nomeClasse), "Avioes");
                case ClassePublico: format(nomeClasse, sizeof(nomeClasse), "Publicos");
                case ClasseSalao: format(nomeClasse, sizeof(nomeClasse), "Carros de Salao");
                case ClasseSport: format(nomeClasse, sizeof(nomeClasse), "Carros Sport");
                case ClasseTrailer: format(nomeClasse, sizeof(nomeClasse), "Trailers");
                case ClasseUnicos: format(nomeClasse, sizeof(nomeClasse), "Carros Unicos");
                case ClasseBasicos: format(nomeClasse, sizeof(nomeClasse), "Carros Basicos");
            }
            new v = 0;
            for(new i = 0; i < sizeof(ClasseVeiculo); i++) {
                if(ClasseVeiculo[i][vClasse] == Classe) {
                    veiculos[v] = ClasseVeiculo[i][vModeloID];
                    v++;
                }
            }
            ShowModelSelectionMenuEx(playerid, veiculos, v, nomeClasse, LISTA_VEICULOS, -17.0, 2.0, 30.0, 0.85);
            return 1;
        }
        case DialogTeleportLista: {
            if(!response) return 1;
            if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{32CD32}* Você deve sair primeiramente de uma arena, use /sairarena.");
            switch(listitem) {
                case 0: return cmd_stunts(playerid, "");
                case 1: return cmd_pistas(playerid, "");
                case 2: return cmd_drift(playerid, "");
                case 3: return cmd_pulos(playerid, "");
                case 4: return cmd_corridas(playerid, "");
                case 5: return cmd_tubos(playerid, "");
                case 6: return cmd_varios(playerid, "");
                case 7: return cmd_tlnormal(playerid, "");
                case 8: return cmd_arenas(playerid, "");

            }
            return 1;
        }
        case DialogTeleStunt: {
            if(!response) return 1;
			if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{32CD32}* Você deve sair primeiramente de uma arena, use /sairarena.");
			new Teles, Msg[144];
            for(new i; i < sizeof(Teleportes); i++) {
                if(Teleportes[i][teleTipo] != Tele_Stunt) continue;
                if(listitem != Teles) {
                    Teles++;
                    continue;
                }
                if(GetPlayerVehicleSeat(playerid) == 0) {
                    SetVehiclePos(GetPlayerVehicleID(playerid), Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ] + 1.0);
                    SetVehicleZAngle(GetPlayerVehicleID(playerid), Teleportes[i][tRot]);
                }
                else {
                    SetPlayerPos(playerid, Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ]);
                    SetPlayerFacingAngle(playerid, Teleportes[i][tRot]);
                }
                if(Teleportes[i][tCarregar] == true) {
                    GameTextForPlayer(playerid, "~w~Carregando...", 3000, 4);
                    TogglePlayerControllable(playerid, false);
                    SetTimerEx("Descongelar", 3000, false, "d", playerid);
                }
                format(Msg, 144, "%s foi para %s ( /%s )", PlayerInfo[playerid][pNome], Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
                new randCor = random (sizeof(CorTeles));
                SendClientMessageToAll(CorTeles[randCor], Msg);
                break;
            }
            return 1;
        }
        case DialogTelePistas: {
            if(!response) return 1;
			if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{32CD32}* Você deve sair primeiramente de uma arena, use /sairarena.");            
            new Teles, Msg[144];
            for(new i; i < sizeof(Teleportes); i++) {
                if(Teleportes[i][teleTipo] != Tele_Pistas) continue;
                if(listitem != Teles) {
                    Teles++;
                    continue;
                }
                if(GetPlayerVehicleSeat(playerid) == 0) {
                    SetVehiclePos(GetPlayerVehicleID(playerid), Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ] + 1.0);
                    SetVehicleZAngle(GetPlayerVehicleID(playerid), Teleportes[i][tRot]);
                }
                else {
                    SetPlayerPos(playerid, Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ]);
                    SetPlayerFacingAngle(playerid, Teleportes[i][tRot]);
                }
                if(Teleportes[i][tCarregar] == true) {
                    GameTextForPlayer(playerid, "~w~Carregando...", 3000, 4);
                    TogglePlayerControllable(playerid, false);
                    SetTimerEx("Descongelar", 3000, false, "d", playerid);
                }
                format(Msg, 144, "%s foi para %s ( /%s )", PlayerInfo[playerid][pNome], Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
                new randCor = random (sizeof(CorTeles));
                SendClientMessageToAll(CorTeles[randCor], Msg);
                break;
            }
            return 1;
        }
        case DialogTeleDrift: {
            if(!response) return 1;
			if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{32CD32}* Você deve sair primeiramente de uma arena, use /sairarena.");
            new Teles, Msg[144];
            for(new i; i < sizeof(Teleportes); i++) {
                if(Teleportes[i][teleTipo] != Tele_Drift) continue;
                if(listitem != Teles) {
                    Teles++;
                    continue;
                }
                if(GetPlayerVehicleSeat(playerid) == 0) {
                    SetVehiclePos(GetPlayerVehicleID(playerid), Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ] + 1.0);
                    SetVehicleZAngle(GetPlayerVehicleID(playerid), Teleportes[i][tRot]);
                }
                else {
                    SetPlayerPos(playerid, Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ]);
                    SetPlayerFacingAngle(playerid, Teleportes[i][tRot]);
                }
                if(Teleportes[i][tCarregar] == true) {
                    GameTextForPlayer(playerid, "~w~Carregando...", 3000, 4);
                    TogglePlayerControllable(playerid, false);
                    SetTimerEx("Descongelar", 3000, false, "d", playerid);
                }
                format(Msg, 144, "%s foi para %s ( /%s )", PlayerInfo[playerid][pNome], Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
                new randCor = random (sizeof(CorTeles));
                SendClientMessageToAll(CorTeles[randCor], Msg);
                break;
            }
            return 1;
        }
        case DialogTelePulos: {
            if(!response) return 1;
			if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{32CD32}* Você deve sair primeiramente de uma arena, use /sairarena.");           
            new Teles, Msg[144];
            for(new i; i < sizeof(Teleportes); i++) {
                if(Teleportes[i][teleTipo] != Tele_Pulos) continue;
                if(listitem != Teles) {
                    Teles++;
                    continue;
                }
                if(GetPlayerVehicleSeat(playerid) == 0) {
                    SetVehiclePos(GetPlayerVehicleID(playerid), Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ] + 1.0);
                    SetVehicleZAngle(GetPlayerVehicleID(playerid), Teleportes[i][tRot]);
                }
                else {
                    SetPlayerPos(playerid, Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ]);
                    SetPlayerFacingAngle(playerid, Teleportes[i][tRot]);
                }
                if(Teleportes[i][tCarregar] == true) {
                    GameTextForPlayer(playerid, "~w~Carregando...", 3000, 4);
                    TogglePlayerControllable(playerid, false);
                    SetTimerEx("Descongelar", 3000, false, "d", playerid);
                }
                format(Msg, 144, "%s foi para %s ( /%s )", PlayerInfo[playerid][pNome], Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
                new randCor = random (sizeof(CorTeles));
                SendClientMessageToAll(CorTeles[randCor], Msg);
                break;
            }
            return 1;
        }
        case DialogTeleCorridas: {
            if(!response) return 1;
			if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{32CD32}* Você deve sair primeiramente de uma arena, use /sairarena.");        
            new Teles, Msg[144];
            for(new i; i < sizeof(Teleportes); i++) {
                if(Teleportes[i][teleTipo] != Tele_Corrida) continue;
                if(listitem != Teles) {
                    Teles++;
                    continue;
                }
                if(GetPlayerVehicleSeat(playerid) == 0) {
                    SetVehiclePos(GetPlayerVehicleID(playerid), Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ] + 1.0);
                    SetVehicleZAngle(GetPlayerVehicleID(playerid), Teleportes[i][tRot]);
                }
                else {
                    SetPlayerPos(playerid, Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ]);
                    SetPlayerFacingAngle(playerid, Teleportes[i][tRot]);
                }
                if(Teleportes[i][tCarregar] == true) {
                    GameTextForPlayer(playerid, "~w~Carregando...", 3000, 4);
                    TogglePlayerControllable(playerid, false);
                    SetTimerEx("Descongelar", 3000, false, "d", playerid);
                }
                format(Msg, 144, "%s foi para %s ( /%s )", PlayerInfo[playerid][pNome], Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
                new randCor = random (sizeof(CorTeles));
                SendClientMessageToAll(CorTeles[randCor], Msg);
                break;
            }
            return 1;
        }
        case DialogTeleTubos: {
            if(!response) return 1;
			if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{32CD32}* Você deve sair primeiramente de uma arena, use /sairarena.");           
            new Teles, Msg[144];
            for(new i; i < sizeof(Teleportes); i++) {
                if(Teleportes[i][teleTipo] != Tele_Tubos) continue;
                if(listitem != Teles) {
                    Teles++;
                    continue;
                }
                if(GetPlayerVehicleSeat(playerid) == 0) {
                    SetVehiclePos(GetPlayerVehicleID(playerid), Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ] + 1.0);
                    SetVehicleZAngle(GetPlayerVehicleID(playerid), Teleportes[i][tRot]);
                }
                else {
                    SetPlayerPos(playerid, Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ]);
                    SetPlayerFacingAngle(playerid, Teleportes[i][tRot]);
                }
                if(Teleportes[i][tCarregar] == true) {
                    GameTextForPlayer(playerid, "~w~Carregando...", 3000, 4);
                    TogglePlayerControllable(playerid, false);
                    SetTimerEx("Descongelar", 3000, false, "d", playerid);
                }
                format(Msg, 144, "%s foi para %s ( /%s )", PlayerInfo[playerid][pNome], Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
                new randCor = random (sizeof(CorTeles));
                SendClientMessageToAll(CorTeles[randCor], Msg);
                break;
            }
            return 1;
        }
        case DialogTeleVariado: {
            if(!response) return 1;
			if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{32CD32}* Você deve sair primeiramente de uma arena, use /sairarena.");            
            new Teles, Msg[144];
            for(new i; i < sizeof(Teleportes); i++) {
                if(Teleportes[i][teleTipo] != Tele_Variados) continue;
                if(listitem != Teles) {
                    Teles++;
                    continue;
                }
                if(GetPlayerVehicleSeat(playerid) == 0) {
                    SetVehiclePos(GetPlayerVehicleID(playerid), Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ] + 1.0);
                    SetVehicleZAngle(GetPlayerVehicleID(playerid), Teleportes[i][tRot]);
                }
                else {
                    SetPlayerPos(playerid, Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ]);
                    SetPlayerFacingAngle(playerid, Teleportes[i][tRot]);
                }
                if(Teleportes[i][tCarregar] == true) {
                    GameTextForPlayer(playerid, "~w~Carregando...", 3000, 4);
                    TogglePlayerControllable(playerid, false);
                    SetTimerEx("Descongelar", 3000, false, "d", playerid);
                }
                format(Msg, 144, "%s foi para %s ( /%s )", PlayerInfo[playerid][pNome], Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
                new randCor = random (sizeof(CorTeles));
                SendClientMessageToAll(CorTeles[randCor], Msg);
                break;
            }
            return 1;
        }
        case DialogTeleNormal: {
            if(!response) return 1;
			if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{32CD32}* Você deve sair primeiramente de uma arena, use /sairarena.");           
            new Teles, Msg[144];
            for(new i; i < sizeof(Teleportes); i++) {
                if(Teleportes[i][teleTipo] != Tele_Normal) continue;
                if(listitem != Teles) {
                    Teles++;
                    continue;
                }
                if(GetPlayerVehicleSeat(playerid) == 0) {
                    SetVehiclePos(GetPlayerVehicleID(playerid), Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ] + 1.0);
                    SetVehicleZAngle(GetPlayerVehicleID(playerid), Teleportes[i][tRot]);
                }
                else {
                    SetPlayerPos(playerid, Teleportes[i][tX], Teleportes[i][tY], Teleportes[i][tZ]);
                    SetPlayerFacingAngle(playerid, Teleportes[i][tRot]);
                }
                format(Msg, 144, "%s foi para %s ( /%s )", PlayerInfo[playerid][pNome], Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
                new randCor = random (sizeof(CorTeles));
                SendClientMessageToAll(CorTeles[randCor], Msg);
                break;
            }
            return 1;
        }
        case DialogComandosClasse: {
            if(!response) return 1;
            SetPVarInt(playerid, "cmd_lista", 0);
            new cmdClasse = listitem + 1;
            SetPVarInt(playerid, "cmd_classe", cmdClasse);
            new Dialog[2000], comandos;
            for(new i = 0; i < sizeof(Cmds); i++) {
                if(Cmds[i][ComandoClasse] == cmdClasse) {
                    if(comandos > 30) break;
                    if(Cmds[i][ComandoLevel] <= 0)
                        format(Dialog, sizeof(Dialog), "%s- %s\t%s\n", Dialog, Cmds[i][ComandoNome], Cmds[i][ComandoInfo]);
                    else {
                        if(PlayerInfo[playerid][pLevel] >= Cmds[i][ComandoLevel])
                            format(Dialog, sizeof(Dialog), "%sLevel %i - %s\t - \t%s\n", Dialog, Cmds[i][ComandoLevel], Cmds[i][ComandoNome], Cmds[i][ComandoInfo]);
                    }
                    comandos++;
                    SetPVarInt(playerid, "cmd_lista", i+1);
                }
            }
            if(comandos == 0) return SendClientMessage(playerid, -1, "{ff0000}Não há comandos nesta opção!"), cmd_cmds(playerid, "");
            ShowPlayerDialog(playerid, DialogComandos, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Página de Comandos", Dialog, "Ok", "Voltar");
            return 1;
        }
        case DialogComandos: {
            if(!response) return cmd_cmds(playerid, "");
            new cmdClasse = GetPVarInt(playerid, "cmd_classe");
            new Dialog[2000], comandos;
            for(new i = GetPVarInt(playerid, "cmd_lista"); i < sizeof(Cmds); i++) {
                if(Cmds[i][ComandoClasse] == cmdClasse) {
                    if(comandos > 30) break;
                    if(Cmds[i][ComandoLevel] <= 0)
                        format(Dialog, sizeof(Dialog), "%s- %s\t%s\n", Dialog, Cmds[i][ComandoNome], Cmds[i][ComandoInfo]);
                    else {
                        if(PlayerInfo[playerid][pLevel] >= Cmds[i][ComandoLevel])
                            format(Dialog, sizeof(Dialog), "%sLevel %i - %s\t - \t%s\n", Dialog, Cmds[i][ComandoLevel], Cmds[i][ComandoNome], Cmds[i][ComandoInfo]);
                    }
                    comandos++;
                    SetPVarInt(playerid, "cmd_lista", i + 1);
                }
            }
            if(comandos == 0) return SendClientMessage(playerid, -1, "{ff0000}Nada encontrado!"), cmd_cmds(playerid, "");
            ShowPlayerDialog(playerid, DialogComandos, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Página de Comandos", Dialog, "Ok", "Voltar");
            return 1;
        }
        case DialogArenasDM: {
            if(!response) return 1;
            new Msg[144], spawn;
            spawn = random(3);
            if(ArenasDM[listitem][ax][spawn] == 0)
                spawn = random(2);
            if(ArenasDM[listitem][ax][spawn] == 0)
                spawn = random(1);
            if(ArenasDM[listitem][ax][spawn] == 0)
                spawn = 0;
            SetPlayerPos(playerid, ArenasDM[listitem][ax][spawn], ArenasDM[listitem][ay][spawn], ArenasDM[listitem][az][spawn]);
            SetPlayerFacingAngle(playerid, ArenasDM[listitem][aRot][spawn]);
            SetPlayerInterior(playerid, ArenasDM[listitem][ArenaInterior]);
            ResetPlayerWeapons(playerid);
            for(new i; i < 14; i++)
                GivePlayerWeapon(playerid, ArenasDM[listitem][ArenaArmas][i], 99999);
            format(Msg, 144, "{483D8B}* %s foi até a arena %s (%s)", PlayerInfo[playerid][pNome], ArenasDM[listitem][ArenaNome], ArenasDM[listitem][ArenaCmd]);
            SendClientMessageToAll(-1, Msg);
            PlayerInfo[playerid][ArenaID] = listitem;
            PlayerInfo[playerid][EmArena] = true;
            GameTextForPlayer(playerid, "~w~Para sair da arena, use ~r~/sairarena~w~.", 5000, 4);
            return 1;
        }
        case DialogDescalar: {
            if(!response) return 1;
            return cmd_descalar(playerid, inputtext);
        }
        case DialogRadio: {
            if(!response) return 1;
            new radio = listitem;
            if(radio < sizeof(WebRadios) && strlen(WebRadios[radio][NomeWebRadio]) > 0)
            {
                new Msg[144];
                PlayAudioStreamForPlayer(playerid, WebRadios[radio][ipWebRadio]);
                format(Msg, 144, "{a9c4e4}Você está ouvindo: {ffffff}%s{a9c4e4}.", WebRadios[radio][NomeWebRadio]);
                SendClientMessage(playerid, -1, Msg);
            }
            else
            {
                StopAudioStreamForPlayer(playerid);
                SendClientMessage(playerid, -1, "{a9c4e4}Som {ffffff}parado!");
            }
            return 1;
        }
        case DialogMudarSenha: {
            if(!response || strlen(inputtext) <= 1) return 1;
            if(!strcmp(Descriptar(PlayerInfo[playerid][pSenha]), inputtext, false)) {
                return ShowPlayerDialog(playerid, DialogNovaSenha, DIALOG_STYLE_PASSWORD, "{ff0000}# {ffffff}Digite a nova senha", "Você digitou corretamente sua senha antiga, agora digite a nova senha", "Ok", "");
            }
            else
                SendClientMessage(playerid, -1, "{ff0000}Senha inválida ou incorreta.");
            return 1;
        }
        case DialogNovaSenha: {
            if(!response || strlen(inputtext) <= 1) return 1;
            if(!strcmp(inputtext, Descriptar(PlayerInfo[playerid][pSenha]), false)) return SendClientMessage(playerid, -1, "{ff0000}Sua nova senha não pode ser igual a antiga.");
            SetPVarString(playerid, "nova_senha", inputtext);
            ShowPlayerDialog(playerid, DialogConfirmarSenha, DIALOG_STYLE_PASSWORD, "{ff0000}# {ffffff}Confirmar nova senha", "Digite novamente sua nova senha:", "Ok", "");
            return 1;
        }
        case DialogConfirmarSenha: {
            if(!response || strlen(inputtext) <= 1) return 1;
            if(!strcmp(inputtext, Descriptar(PlayerInfo[playerid][pSenha]), false)) return SendClientMessage(playerid, -1, "{ff0000}Sua nova senha não pode ser igual a antiga.");
            new SenhaDigitada[50];
            GetPVarString(playerid, "nova_senha", SenhaDigitada, 50);
            if(strcmp(inputtext, SenhaDigitada, false) != 0) return SendClientMessage(playerid, -1, "{ff0000}Você não havia digitado esta senha anteriormente."), DeletePVar(playerid, "nova_senha");
            format(PlayerInfo[playerid][pSenha], 50, Encriptar(inputtext));
            ShowPlayerDialog(playerid, DialogSemResposta, DIALOG_STYLE_MSGBOX, "{ffff00}# {ffffff}Senha alterada!", "Sua senha foi alterada com sucesso!\nNão se esqueça de sua senha para logar novamente!", "Ok", "");
            return 1;
        }
        case DialogPorNeon: {
			if(!response) return 1;
			new Neon = listitem + 1;
			new vid = GetPlayerVehicleID(playerid);
			if(VehInfo[vid][NeonDireito] != 0) {
				DestroyDynamicObject(VehInfo[vid][NeonDireito]);
				VehInfo[vid][NeonDireito] = 0;
				DestroyDynamicObject(VehInfo[vid][NeonEsquerdo]);
				VehInfo[vid][NeonEsquerdo] = 0;
			}
			if(Neon < sizeof(Neons)) {
				VehInfo[vid][NeonDireito] = CreateDynamicObject(Neons[Neon][NeonID],0,0,0,0,0,0);
				VehInfo[vid][NeonEsquerdo] = CreateDynamicObject(Neons[Neon][NeonID],0,0,0,0,0,0);
				AttachDynamicObjectToVehicle(VehInfo[vid][NeonEsquerdo], vid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				AttachDynamicObjectToVehicle(VehInfo[vid][NeonDireito], vid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
				VehInfo[vid][NeonID] = Neon;
			}
			else
			    VehInfo[vid][NeonID] = 0;
			if(vid == PlayerInfo[playerid][pVeh])
			    PlayerInfo[playerid][NeonID] = VehInfo[vid][NeonID];
			Streamer_Update(playerid);
			SalvarConta(playerid);
			return 1;
		}
		case DialogRodas: {
		    if(!response) return 1;
		    new Msg[128];
			if(listitem < sizeof(Rodas)) {
				AddVehicleComponent(GetPlayerVehicleID(playerid), Rodas[listitem][RodaID]);
			    format(Msg, 128, "~y~%s~n~~w~inserida!", Rodas[listitem][RodaNome]);
			    GameTextForPlayer(playerid, Msg, 5000, 4);
			}
			else {
				RemoveVehicleComponent(GetPlayerVehicleID(playerid), VehInfo[GetPlayerVehicleID(playerid)][vehComponentes][7]);
				GameTextForPlayer(playerid, "~w~Roda restaurada!", 5000, 4);
			}
		    return 1;
		}
		case DialogVehCor: {
			if(!response || strlen(inputtext) == 0) return DeletePVar(playerid, "Cor_pag");
			if((strfind(inputtext, "Próxima", true) > -1) || (strfind(inputtext, "Prox", true) > -1)) return SetPVarInt(playerid, "Cor_pag", GetPVarInt(playerid, "Cor_pag") + 100), cmd_cor(playerid, "");
			DeletePVar(playerid, "Cor_pag");
			new Cores[2];
			sscanf(inputtext, "p<,>a<i>[2]", Cores);
			return ChangeVehicleColor(GetPlayerVehicleID(playerid), Cores[0], Cores[1]);
		}
    }
	return 0;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(PlayerInfo[playerid][pLevel] == 0) return 1;
	if(playerid == clickedplayerid) return 1;
	new Float:pos[3];
	GetPlayerPos(clickedplayerid, pos[0], pos[1], pos[2]);
	SetPlayerPos(playerid, pos[0], pos[1], pos[2]+1.0);
	return 1;
}
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return RepairVehicle(vehicleid);
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == PlayerInfo[playerid][DrawStatus][4]) {
		for(new i; i < 11; i++) {
			if(PlayerInfo[playerid][DrawStatus][i] == PlayerText:INVALID_TEXT_DRAW) continue;
			PlayerTextDrawDestroy(playerid, PlayerInfo[playerid][DrawStatus][i]);
			PlayerInfo[playerid][DrawStatus][i] = PlayerText:INVALID_TEXT_DRAW;
		}
		CancelSelectTextDraw(playerid);
		return 1;
	}
	return 0;
}
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ) {
    SetPlayerPosFindZ(playerid, fX, fY, fZ);
	return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW) { // Pressionar Esc
		if(PlayerInfo[playerid][DrawStatus][0] != PlayerText:INVALID_TEXT_DRAW) {
			for(new i; i < 11; i++) {
				if(PlayerInfo[playerid][DrawStatus][i] == PlayerText:INVALID_TEXT_DRAW) continue;
				PlayerTextDrawDestroy(playerid, PlayerInfo[playerid][DrawStatus][i]);
				PlayerInfo[playerid][DrawStatus][i] = PlayerText:INVALID_TEXT_DRAW;
			}
			return 1;
		}
	}
	return 0;
}
//0.3z
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) {
	return 1;
}
// mSelection
public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    if (listid == SKIN_LISTA) {
        if(!response) return 1;
        return SetPlayerSkin(playerid, modelid), PlayerTextDrawSetPreviewModel(playerid, PlayerInfo[playerid][PlayerDano][1], modelid), PlayerTextDrawShow(playerid, PlayerInfo[playerid][PlayerDano][1]);
    }
    if(listid == ARMA_LISTA) {
        if(!response) return 1;
        switch (modelid) {
        	case 331: GivePlayerWeapon(playerid, 1, AMMO); // Brass Knuckles
        	case 333: GivePlayerWeapon(playerid, 2, AMMO); // Golf Club
        	case 334: GivePlayerWeapon(playerid, 3, AMMO); // Nightstick
        	case 335: GivePlayerWeapon(playerid, 4, AMMO); // Knife
        	case 336: GivePlayerWeapon(playerid, 5, AMMO); // Baseball Bat
        	case 337: GivePlayerWeapon(playerid, 6, AMMO); // Shovel
        	case 338: GivePlayerWeapon(playerid, 7, AMMO); // Pool Cue
        	case 339: GivePlayerWeapon(playerid, 8, AMMO); // Katana
        	case 341: GivePlayerWeapon(playerid, 9, AMMO); // Chainsaw
        	case 321: GivePlayerWeapon(playerid, 10, AMMO); // Double-ended Dildo
        	case 325: GivePlayerWeapon(playerid, 14, AMMO); // Flowers
        	case 326: GivePlayerWeapon(playerid, 15, AMMO); // Cane
        	case 342: GivePlayerWeapon(playerid, 16, AMMO); // Grenade
        	case 343: GivePlayerWeapon(playerid, 17, AMMO); // Tear Gas
        	case 344: GivePlayerWeapon(playerid, 18, AMMO); // Molotov Cocktail
        	case 346: GivePlayerWeapon(playerid, 22, AMMO); // 9mm
        	case 347: GivePlayerWeapon(playerid, 23, AMMO); // Silenced 9mm
        	case 348: GivePlayerWeapon(playerid, 24, AMMO); // Desert Eagle
        	case 349: GivePlayerWeapon(playerid, 25, AMMO); // Shotgun
        	case 350: GivePlayerWeapon(playerid, 26, AMMO); // Sawnoff
        	case 351: GivePlayerWeapon(playerid, 27, AMMO); // Combat Shotgun
        	case 352: GivePlayerWeapon(playerid, 28, AMMO); // Micro SMG/Uzi
        	case 353: GivePlayerWeapon(playerid, 29, AMMO); // MP5
        	case 355: GivePlayerWeapon(playerid, 30, AMMO); // AK-47
        	case 356: GivePlayerWeapon(playerid, 31, AMMO); // M4
        	case 372: GivePlayerWeapon(playerid, 32, AMMO); // Tec-9
        	case 357: GivePlayerWeapon(playerid, 33, AMMO); // Country Rifle
        	case 358: GivePlayerWeapon(playerid, 34, AMMO); // Sniper Rifle
        	case 359: GivePlayerWeapon(playerid, 35, AMMO); // RPG
        	case 360: GivePlayerWeapon(playerid, 36, AMMO); // HS Rocket
        	case 361: GivePlayerWeapon(playerid, 37, AMMO); // Flamethrower
        	case 362: GivePlayerWeapon(playerid, 38, AMMO); // Minigun
        	case 363: { GivePlayerWeapon(playerid, 39, AMMO); GivePlayerWeapon(playerid, 40, 1); }// Satchel Charge + Detonator
        	case 365: GivePlayerWeapon(playerid, 41, AMMO); // Spraycan
        	case 366: GivePlayerWeapon(playerid, 42, AMMO); // Fire Extinguisher
        }
        return 1;
    }
    return 1;
}
public OnPlayerModelSelectionEx(playerid, response, extraid, modelid)
{
    switch(extraid) {
        case LISTA_VEICULOS: {
            if(!response) return cmd_v(playerid, "");
            new Float:p[4], vid, Msg[144], Cores[2]; GetPlayerPos(playerid, p[0], p[1], p[2]);
            GetPlayerFacingAngle(playerid, p[3]);
			Cores[0] = random(255);
			Cores[1] = random(255);
            vid = CreateVehicle(modelid, p[0], p[1], p[2], p[3], Cores[0], Cores[1], 120);
            if(vid == INVALID_VEHICLE_ID) return SendClientMessage(playerid, -1, "{ffff00}Lamentamos, seu veículo não foi criado por causa do exesso de veículos no servidor.");
			if(GetPlayerVehicleID(playerid) != 0 && GetPlayerVehicleID(playerid) != PlayerInfo[playerid][pVeh])
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
            if(PlayerInfo[playerid][pVeh] != 0 && PlayerInfo[playerid][pVeh] != vid) {
                DestroyVehicle(PlayerInfo[playerid][pVeh]);
            }
			PlayerInfo[playerid][pVeh] = vid;
			PlayerInfo[playerid][VehModelo] = modelid;
			for(new i; i < 2; i++)
				PlayerInfo[playerid][VehCores][i] = Cores[i];
			for(new i; i < 14; i++)
			    PlayerInfo[playerid][VehComponentes][i] = 0;
            LinkVehicleToInterior(vid, GetPlayerInterior(playerid));
            SetVehicleVirtualWorld(vid, GetPlayerVirtualWorld(playerid));
            PutPlayerInVehicle(playerid, vid, 0);
            VehInfo[vid][DonoID] = playerid;
            format(Msg, sizeof(Msg), "{ffff00}%s criou um %s", PlayerInfo[playerid][pNome], NomesVeiculos[modelid - 400]);
            SendClientMessageToAll(-1, Msg);
            SalvarConta(playerid);
            return 1;
        }
    }
    return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[]) {
    if(PlayerInfo[playerid][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar comandos sem estar logado!"), 0;
    return 1;
}
public OnPlayerCommandPerformed(playerid, cmdtext[], success) {
    if(!success) {
        new Msg[128];
        for(new i; i < strlen(cmdtext); i++)
            if(cmdtext[i] == '~')
                strdel(cmdtext, i, i+1);
        format(Msg, 128, "~w~comando ~r~%s~w~ nao existe!", cmdtext);
        GameTextForPlayer(playerid, Msg, 5000, 4);
        return 1;
    }
    else
	{
		printf("[%s] [id: %i]: %s", PlayerInfo[playerid][pNome], playerid, cmdtext);
	}
    return 1;
}
/*
    Stocks e Outras
*/
stock TodasGangs(playerid) {
	new Cache:G, Nome[128], Query[128], Lista[2000];
    format(Query, sizeof(Query), "SELECT Nome FROM gangs ORDER BY id DESC LIMIT %i,50", GetPVarInt(playerid, "pag_gangs"));
    G = mysql_query(mysql, Query, true);
    if(!cache_num_rows(mysql)) SendClientMessage(playerid, -1, "{ff0000}Erro!");
    else {
        for(new i; i < cache_num_rows(mysql); i++) {
            cache_get_field_content(0, "Nome", Nome, mysql, 128);
            format(Lista, sizeof(Lista), "%s%s\r\n", Lista, Nome);
        }
        if(cache_num_rows(mysql) >= 50)
            strcat(Lista, "\r\n\r\n{ffff00}Próxima página");
    	ShowPlayerDialog(playerid, DialogGangs, DIALOG_STYLE_LIST, "{ffff00}# {ffffff}Gangs", Lista, "Selecionar", "Cancelar");
    }
    cache_delete(G, mysql);
	return 1;
}
stock CriarGang(gangid)
{
	new Query[500], Cache:C;
	mysql_format(mysql, Query, sizeof(Query), "INSERT INTO gangs (Nome,Lider,Cor,TAG,Descricao) VALUES ('%e',%i,%x,'%e','%e')", Gangs[gangid][GangNome], Gangs[gangid][Lider], Gangs[gangid][GangCor], Gangs[gangid][GangTag], Gangs[gangid][GangDescricao]);
	C = mysql_query(mysql, Query, true);
	Gangs[gangid][ID_MySQL] = cache_insert_id(mysql);
	cache_delete(C, mysql);
	return 1;
}

stock MenuGang(playerid)
{
	if(Gangs[PlayerInfo[playerid][pGang]][Lider] == PlayerInfo[playerid][pMySQL_ID] || Gangs[PlayerInfo[playerid][pGang]][SubLider] == PlayerInfo[playerid][pMySQL_ID])
	{
		new NicK[200];
		strcat(NicK, "Adicionar Sub-Lider\r\n");
		strcat(NicK, "Convidar membro\r\n");
		strcat(NicK, "Administrar membros\r\n");
		strcat(NicK, "Ver áreas dominadas\r\n");
		strcat(NicK, "Editar descrição da Gang\r\n");
		strcat(NicK, "Deletar Gang\r\n");
		ShowPlayerDialog(playerid, DialogGangMenu, DIALOG_STYLE_LIST, "{0000ff}# {ffffff}Menu da Gang", NicK, "Selecionar", "Cancelar");
	}
	else
		SendClientMessage(playerid, -1, "{ff0000}Você não é o lider da gang e não pode acessar o menu!");
	return 1;

}
stock MembrosGang(playerid) {
	new Query[128], Cache:M, Nome[24], Msg[2000], Topo[128], Total;
	for(new i; i < MAX_GANG_MEMBROS; i++)
	{
		if(Gangs[PlayerInfo[playerid][pGang]][GangMembros][i] == 0) continue;
		mysql_format(mysql, Query,sizeof(Query), "SELECT Nome FROM usuarios WHERE id=%i",Gangs[PlayerInfo[playerid][pGang]][GangMembros][i]);
		M = mysql_query(mysql, Query, true);
		if(cache_num_rows(mysql) > 0)
		{
			cache_get_field_content(0, "Nome", Nome, mysql, 24);
			format(Msg, sizeof(Msg), "%s%s\r\n", Msg, Nome);
			Total++;
		}
		cache_delete(M, mysql);
	}
	if(Total == 0) return SendClientMessage(playerid, -1, "{ff0000}Nenhum membro em sua gang!"), MenuGang(playerid);
	format(Topo, 128, "{0000ff}# {ffffff}Sua gang possui %i membros", Total);
	ShowPlayerDialog(playerid, DialogGangMembros, DIALOG_STYLE_LIST, Topo, Msg, "Selecionar", "Cancelar");
	return 1;
}
stock AreasGang(playerid) {
	new Msg[2000], Topo[128], Total;
	for(new i; i < MAX_GANG_AREAS; i++) {
		if(Gangs[PlayerInfo[playerid][pGang]][GangAreas][i] == 0) continue;
		format(Msg, sizeof(Msg), "%s%s\r\n", Msg, Areas[Gangs[PlayerInfo[playerid][pGang]][GangAreas][i]][AreaNome]);
		Total++;
	}
	if(Total == 0) return SendClientMessage(playerid, -1, "{ff0000}Nenhuma area de sua gang!"), MenuGang(playerid);
	format(Topo, 128, "{ff0000}# {ffffff}Sua gang possui %i areas", Total);
	ShowPlayerDialog(playerid, DialogGangAreas, DIALOG_STYLE_LIST, Topo, Msg, "Selecionar", "Cancelar");
	return 1;
}
stock GetWeaponSlot(weaponid)
{
	switch(weaponid)
	{
		case 0,1: return 0;
		case 2 .. 9: return 1;
		case 10 .. 15: return 10;
		case 16 .. 18, 39: return 8;
		case 22 .. 24:  return 2;
		case 25 .. 27: return 3;
		case 28, 29, 32: return 4;
		case 30, 31: return 5;
		case 33, 34: return 6;
		case 35 .. 38: return 7;
		case 40: return 12;
		case 41 .. 43: return 9;
		case 44 .. 46: return 11;
	}
	return 0;
}
forward TirarDrawDano(playerid);
public TirarDrawDano(playerid) {
	if(GetPVarInt(playerid, "info_dano") > gettime()) return SetTimerEx("TirarDrawDano", 1000, false, "d", playerid);
	for(new i = 2; i < 9; i++)
	    PlayerTextDrawHide(playerid, PlayerInfo[playerid][PlayerDano][i]);
	return 1;
}
forward ModoDriftAtivo(playerid);
public ModoDriftAtivo(playerid) return (PlayerInfo[playerid][ModoDrift] == 1) ? (1) : (0);
forward AtualizarPontosDrift(playerid, pontos);
public AtualizarPontosDrift(playerid, pontos) {
	if(PlayerInfo[playerid][ModoDrift] == 0) return 0;
	PlayerInfo[playerid][pDriftPontosTotal] += pontos;
	for(new i; i < 2; i++)
	    PlayerTextDrawHide(playerid, PlayerInfo[playerid][DriftDraw][i]);
	return 1;
}
stock IsVehicleInUse(vid) { // by NicK
	for(new i; i <= GetMaxPlayers(); i++) {
		if(!IsPlayerConnected(i)) continue;
		if(GetPlayerVehicleID(i) == 0) continue;
		if(GetPlayerVehicleID(i) == vid) return 1; // Valor verdadero - Alguém usando.
		if(GetVehicleTrailer(GetPlayerVehicleID(i)) == vid) return 1; //Alguém usando
	}
	return 0; //Valor falso - Ninguém usando
}
stock KickMsg(playerid, msgKick[]) {
    SendClientMessage(playerid, 0xFF0000FF, msgKick);
    SetTimerEx("Kickar", 300, false, "d", playerid);
    return 1;
}
forward Kickar(playerid); public Kickar(playerid) return Kick(playerid);
forward Global();
public Global() {
    new str[256], hora, minutos, seg;
    gettime(hora, minutos, seg);
    format(str, sizeof(str), "%02d:%02d", hora, minutos);
    TextDrawSetString(Draws[7], str);
    format(str, sizeof(str), "%i/%i", GetPlayers(), GetMaxPlayers());
    TextDrawSetString(Draws[10], str);
	format(str, sizeof(str), ":%02d", seg);
    TextDrawSetString(Draws[11], str);
    for(new playerid; playerid < GetMaxPlayers(); playerid++) {
        if(!IsPlayerConnected(playerid)) continue;
        if(IsPlayerNPC(playerid)) continue;
        format(str, sizeof(str), "~w~Mortes: ~r~%i ~w~- Matou: ~g~%i~w~ - Scores: ~b~%i ~w~- Corridas: ~g~~h~%i~n~~w~Golds: ~y~%i ~w~- Drift: ~b~~h~%i ~w~- Ping: ~g~%i ~w~- FPS: ~y~%i", PlayerInfo[playerid][pMorreu], PlayerInfo[playerid][pMatou], PlayerInfo[playerid][pScore], PlayerInfo[playerid][pCorridas], PlayerInfo[playerid][pGold], PlayerInfo[playerid][pDriftPontosTotal], GetPlayerPing(playerid), PlayerInfo[playerid][pFPS]);
        PlayerTextDrawSetString(playerid, PlayerInfo[playerid][DrawInfo], str);
		if(PlayerInfo[playerid][EmCorrida] == true && Corridas[PlayerInfo[playerid][CorridaID]][Iniciada] == true) {
			format(str, sizeof(str), "%i", PlayerInfo[playerid][pCorridaPos]);
			PlayerTextDrawSetString(playerid, PlayerInfo[playerid][CorridaPosInfo], str);
		}
    }
    for(new corridaid = 1; corridaid < MAX_CORRIDAS; corridaid++)
	{
		if(Corridas[corridaid][Carregada] == false) continue;
		format(str, sizeof(str), "%i", GetPlayersCorrida(corridaid));
		TextDrawSetString(Corridas[corridaid][CorridaDraws][3], str);
	}
    return 1;
}
stock GetPlayers() {
    new p;
    for(new i = 0; i <= GetMaxPlayers(); i++) {
        if(!IsPlayerConnected(i)) continue;
        if(IsPlayerNPC(i)) continue;
        p++;
    }
    return p;
}
stock SalvarConta(playerid) {
	PlayerInfo[playerid][pTempoJogado] += (gettime() - PlayerInfo[playerid][pTempoLogado]);
	orm_update(PlayerInfo[playerid][OrmID]);
    return 1;
}
stock RegistroDialog(playerid, Aviso[] = "") {
    new Dialog[300];
    format(Dialog, sizeof(Dialog), "{ffffff}Olá {76EE00}%s{ffffff}, seja bem vindo.\nPara se registrar, digite uma senha abaixo!\n\n%s", PlayerInfo[playerid][pNome], Aviso);
    return ShowPlayerDialog(playerid, DialogRegistrar, DIALOG_STYLE_PASSWORD, "{76EE00}# {ffffff}Registre-se no servidor.", Dialog, "Registrar", "Cancelar");
}
stock LoginDialog(playerid, Aviso[] = "") {
    new Dialog[300];
    format(Dialog, sizeof(Dialog), "{ffffff}Seja bem vindo de volta {FF4500}%s{ffffff}.\nPara fazer o login, digite a sua senha abaixo.\n\n%s", PlayerInfo[playerid][pNome], Aviso);
    return ShowPlayerDialog(playerid, DialogLogar, DIALOG_STYLE_PASSWORD, "{FF4500}# {ffffff}Faça login", Dialog, "Logar", "Cancelar");
}
forward Frases(); public Frases() {
    SendClientMessageToAll(-1, FrasesRandomicas[Frase_Randomica]);
    Frase_Randomica++;
    if(Frase_Randomica >= sizeof(FrasesRandomicas))
        Frase_Randomica=0;
    return 1;
}

forward Descongelar(playerid);
public Descongelar(playerid) { return TogglePlayerControllable(playerid, true); }

stock nick_DrawsStatus(playerid) {
	new string[500];
	PlayerInfo[playerid][DrawStatus][0] = CreatePlayerTextDraw(playerid,300.000000, 141.000000, "~r~# ~w~Status");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][DrawStatus][0], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][0], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][0], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][0], 0.380000, 1.500000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][0], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][0], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][0], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][DrawStatus][0], 0);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][DrawStatus][0], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][DrawStatus][0], 96);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][DrawStatus][0], 60.000000, 251.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][0], 0);

	PlayerInfo[playerid][DrawStatus][1] = CreatePlayerTextDraw(playerid,300.000000, 159.000000, "_");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][DrawStatus][1], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][1], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][1], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][1], 0.500000, 19.100000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][1], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][1], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][1], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][DrawStatus][1], 1);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][DrawStatus][1], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][DrawStatus][1], 53);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][DrawStatus][1], 0.000000, 251.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][1], 0);

	PlayerInfo[playerid][DrawStatus][2] = CreatePlayerTextDraw(playerid,381.000000, 159.000000, "Ranking");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][DrawStatus][2], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][2], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][2], 2);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][2], 0.300000, 1.300000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][2], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][2], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][2], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][DrawStatus][2], 0);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][DrawStatus][2], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][DrawStatus][2], 204576);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][DrawStatus][2], 15.000000, 88.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][2], 0);

	PlayerInfo[playerid][DrawStatus][3] = CreatePlayerTextDraw(playerid,216.000000, 159.000000, "Informacoes");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][DrawStatus][3], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][3], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][3], 2);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][3], 0.300000, 1.300000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][3], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][3], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][3], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][DrawStatus][3], 0);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][DrawStatus][3], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][DrawStatus][3], 204576);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][DrawStatus][3], 15.000000, 82.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][3], 0);

	PlayerInfo[playerid][DrawStatus][4] = CreatePlayerTextDraw(playerid,306.000000, 318.000000, "Fechar");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][DrawStatus][4], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][4], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][4], 2);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][4], 0.330000, 1.500000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][4], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][4], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][4], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][DrawStatus][4], 0);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][DrawStatus][4], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][DrawStatus][4], 520093760);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][DrawStatus][4], 15.000000, 54.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][4], 1);

	format(string, sizeof(string), "Scores: %i~n~Golds: %i~n~~g~R$~w~%i", PlayerInfo[playerid][pScore], PlayerInfo[playerid][pGold], PlayerInfo[playerid][pDinheiro]);
	PlayerInfo[playerid][DrawStatus][5] = CreatePlayerTextDraw(playerid,178.000000, 180.000000, string);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][5], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][5], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][5], 0.300000, 1.300000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][5], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][5], 1);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][5], 1);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][5], 0);

	format(string, sizeof(string), "Mortes: %i~n~Matou: %i", PlayerInfo[playerid][pMorreu], PlayerInfo[playerid][pMatou]);
	PlayerInfo[playerid][DrawStatus][6] = CreatePlayerTextDraw(playerid,352.000000, 180.000000, string);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][6], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][6], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][6], 0.300000, 1.300000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][6], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][6], 1);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][6], 1);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][6], 0);

	new tempo, total;
	tempo = gettime() - PlayerInfo[playerid][pTempoLogado];
	strdel(string, 0, strlen(string));
	if(tempo >= (60*60)) {
		tempo = tempo / (60*60);
		format(string, sizeof(string), "Tempo Log.: %i hrs", tempo);
	}
	else if(tempo >= 60) {
		tempo = tempo / 60;
		format(string, sizeof(string), "Tempo Log.: %i min", tempo);
	}
	else
	    format(string, sizeof(string), "Tempo Log.: %i seg", tempo);

	total = PlayerInfo[playerid][pTempoJogado] + (gettime() - PlayerInfo[playerid][pTempoLogado]);
	new d, h, m; //DIA, HORAS, MIN
	if(total >= (60*60*24)) {
 		d = total / (60*60*24);
		total = total - (d * (60*60*24));
	}
	if(total >= (60*60)) {
		h = total / (60*60);
		total = total - (h * (60*60));
	}
	if(total >= 60) {
		m = total / 60;
		total = total - (m * 60);
	}
	if(d > 0 && h > 0 && m > 0)
		format(string, sizeof(string), "%s~n~Total jogado: %i dia%s, %i hr, %i min", string, d, (d > 1) ? ("s") : (""), h, m);

	PlayerInfo[playerid][DrawStatus][7] = CreatePlayerTextDraw(playerid,178.000000, 218.000000, string);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][7], 255);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][7], 1);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][7], 0.230000, 1.200000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][7], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][7], 1);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][7], 1);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][7], 0);

	PlayerInfo[playerid][DrawStatus][8] = CreatePlayerTextDraw(playerid,129.000000, 236.000000, "Skin");
	PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][DrawStatus][8], 2);
	PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][8], 0x00000000);
	PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][8], 5);
	PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][8], 0.399999, -3.200000);
	PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][8], -1);
	PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][8], 0);
	PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][8], 1);
	PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][DrawStatus][8], 1);
	PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][DrawStatus][8], 1);
	PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][DrawStatus][8], 0);
	PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][DrawStatus][8], 125.000000, 97.000000);
	PlayerTextDrawSetPreviewModel(playerid, PlayerInfo[playerid][DrawStatus][8], GetPlayerSkin(playerid));
	PlayerTextDrawSetPreviewRot(playerid, PlayerInfo[playerid][DrawStatus][8], -16.000000, 0.000000, 20.000000, 1.000000);
	PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][8], 0);

	if(PlayerInfo[playerid][VehModelo] != 0) {
		PlayerInfo[playerid][DrawStatus][9] = CreatePlayerTextDraw(playerid,381.000000, 234.000000, "Veiculo");
		PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][DrawStatus][9], 2);
		PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][9], 255);
		PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][9], 2);
		PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][9], 0.300000, 1.300000);
		PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][9], -1);
		PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][9], 0);
		PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][9], 1);
		PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][DrawStatus][9], 0);
		PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][DrawStatus][9], 1);
		PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][DrawStatus][9], 204576);
		PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][DrawStatus][9], 15.000000, 88.000000);
		PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][9], 0);

		PlayerInfo[playerid][DrawStatus][10] = CreatePlayerTextDraw(playerid,329.000000, 236.000000, "Veiculo");
		PlayerTextDrawAlignment(playerid,PlayerInfo[playerid][DrawStatus][10], 2);
		PlayerTextDrawBackgroundColor(playerid,PlayerInfo[playerid][DrawStatus][10], 0x00000000);
		PlayerTextDrawFont(playerid,PlayerInfo[playerid][DrawStatus][10], 5);
		PlayerTextDrawLetterSize(playerid,PlayerInfo[playerid][DrawStatus][10], 0.399999, -3.200000);
		PlayerTextDrawColor(playerid,PlayerInfo[playerid][DrawStatus][10], -1);
		PlayerTextDrawSetOutline(playerid,PlayerInfo[playerid][DrawStatus][10], 0);
		PlayerTextDrawSetProportional(playerid,PlayerInfo[playerid][DrawStatus][10], 1);
		PlayerTextDrawSetShadow(playerid,PlayerInfo[playerid][DrawStatus][10], 1);
		PlayerTextDrawUseBox(playerid,PlayerInfo[playerid][DrawStatus][10], 1);
		PlayerTextDrawBoxColor(playerid,PlayerInfo[playerid][DrawStatus][10], 0);
		PlayerTextDrawTextSize(playerid,PlayerInfo[playerid][DrawStatus][10], 125.000000, 97.000000);
		PlayerTextDrawSetPreviewModel(playerid, PlayerInfo[playerid][DrawStatus][10], PlayerInfo[playerid][VehModelo]);
		PlayerTextDrawSetPreviewRot(playerid, PlayerInfo[playerid][DrawStatus][10], -16.000000, 0.000000, -30.000000, 1.000000);
		PlayerTextDrawSetSelectable(playerid,PlayerInfo[playerid][DrawStatus][10], 0);
		PlayerTextDrawSetPreviewVehCol(playerid, PlayerInfo[playerid][DrawStatus][10], PlayerInfo[playerid][VehCores][0], PlayerInfo[playerid][VehCores][1]);

	}

	for(new i; i < 11; i++) {
	    if(PlayerInfo[playerid][DrawStatus][i] == PlayerText:INVALID_TEXT_DRAW) continue;
		PlayerTextDrawShow(playerid, PlayerInfo[playerid][DrawStatus][i]);
	}
	SelectTextDraw(playerid, 0xffff0090);
	return 1;
}
/* Anti Spawn Kill */
forward SpawnKill(playerid); public SpawnKill(playerid) { return SetPlayerHealth(playerid, 100.0); }

forward TVMatador(playerid);
public TVMatador(playerid) {
    TogglePlayerSpectating(playerid, false);
    for(new i; i < 2; i++) {
        PlayerTextDrawSetString(playerid, PlayerInfo[playerid][InfoMatador][i], "");
        PlayerTextDrawHide(playerid, PlayerInfo[playerid][InfoMatador][i]);
    }
    return 1;
}
stock GetPlayerSpeed(playerid)
{
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid))
    GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
    else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
    ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 155.0;
    return floatround(ST[3]);
}
forward LimparAnuncio(); public LimparAnuncio() { return TextDrawSetString(DrawAnuncio, ""); }
forward Contando();
public Contando() {
    new Msg[256];
    if(Contagem[ContagemSegundos] > 0) {
        format(Msg, sizeof(Msg), "%i", Contagem[ContagemSegundos]);
        TextDrawSetString(Contagem[DrawContagem], Msg);
        for(new i; i <= GetMaxPlayers(); i++) {
            if(!IsPlayerConnected(i)) continue;
            PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
        }
    }
    else if(Contagem[ContagemSegundos] == 0) {
        format(Msg, sizeof(Msg), "%s", Contagem[TextoContagem]);
        TextDrawSetString(Contagem[DrawContagem], Msg);
        for(new i; i <= GetMaxPlayers(); i++) {
            if(!IsPlayerConnected(i)) continue;
            PlayerPlaySound(i, 3200, 0.0, 0.0, 0.0);
        }
    }
    else if(Contagem[ContagemSegundos] <= (-3)){
        TextDrawSetString(Contagem[DrawContagem], "");
        //KillTimer(Contagem[TempoContagem]);
        Contagem[ContagemSegundos] = 0;
        return 1;
    }
    Contagem[ContagemSegundos]--;
	SetTimer("Contando", 1000, false);
    return 1;
}

stock Encriptar(const string[]) {
    new str[50];
    for(new i; i < strlen(string); i++) {
        str[i] = (string[i] + 2);
    }
    return str;
}
stock Descriptar(const string[]) {
    new str[50];
    for(new i; i < strlen(string); i++) {
        str[i] = (string[i] - 2);
    }
    return str;
}
//Sistema de Corridas - NicK
forward CorridaAleatoria();
public CorridaAleatoria()
{
	//if(GetPlayers() < 10) return 1;
	new Cache:corridas = mysql_query(mysql, "SELECT * FROM corridas ORDER BY ID DESC LIMIT 10", true);
	if(cache_num_rows(mysql) > 0) {
		new corridaid, str[200], Msg[144], ca = random(cache_num_rows(mysql));
		for(corridaid = 1; corridaid < MAX_CORRIDAS; corridaid++) {
	    	if(Corridas[corridaid][EmProjeto] == true) continue;
	    	if(Corridas[corridaid][Carregada] == true) continue;
			break; //no caso, se não houver carregadas nem em projeto.
		}
		if(corridaid == MAX_CORRIDAS) return cache_delete(corridas, mysql), 1;
		Corridas[corridaid][CorridaID] = cache_get_field_content_int(ca, "ID", mysql);
		cache_get_field_content(ca, "CorridaNome", Corridas[corridaid][CorridaNome], mysql, 128);
		Corridas[corridaid][CorridaTipo] = cache_get_field_content_int(ca, "CorridaTipo", mysql);
		Corridas[corridaid][CorridaPremio] = cache_get_field_content_int(ca, "CorridaPremio", mysql);
		Corridas[corridaid][CorridaMaxParticipantes] = cache_get_field_content_int(ca, "MaximoParticipantes", mysql);
		Corridas[corridaid][CorridaVeiculo] = cache_get_field_content_int(ca, "Veiculo", mysql);
		Corridas[corridaid][MaxCheckpoints] = cache_get_field_content_int(ca, "MaxCheckpoints", mysql);
		Corridas[corridaid][CorridaRecord] = cache_get_field_content_int(ca, "CorridaRecord", mysql);
		Corridas[corridaid][RecordBy] = cache_get_field_content_int(ca, "RecordBy", mysql);
		Corridas[corridaid][InicioPos][0] = cache_get_field_content_float(ca, "InicioX", mysql);
		Corridas[corridaid][InicioPos][1] = cache_get_field_content_float(ca, "InicioY", mysql);
		Corridas[corridaid][InicioPos][2] = cache_get_field_content_float(ca, "InicioZ", mysql);
		cache_get_field_content(ca, "CheckpointsX", str, mysql, 200); unformat(str, "p<,>a<f>["#MAX_CHECKPOINTS"]", Corridas[corridaid][CheckpointX]);
        cache_get_field_content(ca, "CheckpointsY", str, mysql, 200); unformat(str, "p<,>a<f>["#MAX_CHECKPOINTS"]", Corridas[corridaid][CheckpointY]);
        cache_get_field_content(ca, "CheckpointsZ", str, mysql, 200); unformat(str, "p<,>a<f>["#MAX_CHECKPOINTS"]", Corridas[corridaid][CheckpointZ]);
		format(Msg, 144, "{ffff00}[CORRIDA AUTOMATICA] Use o comando {ffffff}/ircorrida %i {ffff00}para ir na corrida {ffffff}%s{ffff00}!", corridaid, Corridas[corridaid][CorridaNome]);
		SendClientMessageToAll(-1, Msg);
		Corridas[corridaid][Carregada] = true;
		Corridas[corridaid][Iniciada] = false;
		Corridas[corridaid][Trancada] = false;
		CriarDrawsCorrida(corridaid);
		Corridas[corridaid][CorridaTimerIniciar] = SetTimerEx("IniciarCorrida", 30000, false, "d", corridaid);
	}
	cache_delete(corridas, mysql);
	return 1;
}
forward MySQL_CarregarCorrida();
public MySQL_CarregarCorrida() {
	if(cache_num_rows(mysql) == 0) return 1;
	new corridaid, str[300], Msg[144];
	for(corridaid = 1; corridaid < MAX_CORRIDAS; corridaid++) {
    	if(Corridas[corridaid][EmProjeto] == true) continue;
    	if(Corridas[corridaid][Carregada] == true) continue;
		break; //no caso, se não houver carregadas nem em projeto.
	}
	if(corridaid == MAX_CORRIDAS) return 1;
	Corridas[corridaid][CorridaID] = cache_get_field_content_int(0, "ID", mysql);
	cache_get_field_content(0, "CorridaNome", Corridas[corridaid][CorridaNome], mysql, 128);
	Corridas[corridaid][CorridaTipo] = cache_get_field_content_int(0, "CorridaTipo", mysql);
	Corridas[corridaid][CorridaPremio] = cache_get_field_content_int(0, "CorridaPremio", mysql);
	Corridas[corridaid][CorridaMaxParticipantes] = cache_get_field_content_int(0, "MaximoParticipantes", mysql);
	Corridas[corridaid][CorridaVeiculo] = cache_get_field_content_int(0, "Veiculo", mysql);
	Corridas[corridaid][MaxCheckpoints] = cache_get_field_content_int(0, "MaxCheckpoints", mysql);
	Corridas[corridaid][CorridaRecord] = cache_get_field_content_int(0, "CorridaRecord", mysql);
	Corridas[corridaid][RecordBy] = cache_get_field_content_int(0, "RecordBy", mysql);
	Corridas[corridaid][InicioPos][0] = cache_get_field_content_float(0, "InicioX", mysql);
	Corridas[corridaid][InicioPos][1] = cache_get_field_content_float(0, "InicioY", mysql);
	Corridas[corridaid][InicioPos][2] = cache_get_field_content_float(0, "InicioZ", mysql);
	cache_get_field_content(0, "CheckpointsX", str, mysql, sizeof(str)); unformat(str, "p<,>a<f>["#MAX_CHECKPOINTS"]", Corridas[corridaid][CheckpointX]);
    cache_get_field_content(0, "CheckpointsY", str, mysql, sizeof(str)); unformat(str, "p<,>a<f>["#MAX_CHECKPOINTS"]", Corridas[corridaid][CheckpointY]);
    cache_get_field_content(0, "CheckpointsZ", str, mysql, sizeof(str)); unformat(str, "p<,>a<f>["#MAX_CHECKPOINTS"]", Corridas[corridaid][CheckpointZ]);
	format(Msg, 144, "{ffff00}[CORRIDA CARREGADAA] Use o comando {ffffff}/ircorrida %i {ffff00}para ir na corrida {ffffff}%s{ffff00}!", corridaid, Corridas[corridaid][CorridaNome]);
	SendClientMessageToAll(-1, Msg);
	Corridas[corridaid][Carregada] = true;
	Corridas[corridaid][Iniciada] = false;
	Corridas[corridaid][Trancada] = false;
	CriarDrawsCorrida(corridaid);
	SetTimerEx("IniciarCorrida", 30000, false, "d", corridaid);
	return 1;
}
stock CriarDrawsCorridaParaPlayer(playerid) {
	PlayerInfo[playerid][CorridaPosInfo] = CreatePlayerTextDraw(playerid, 132.000000, 281.000000, "0"); //Posição do player, no caso isso deve ser Playertextdraw para poucos bugs.
	PlayerTextDrawBackgroundColor(playerid, PlayerInfo[playerid][CorridaPosInfo], 255);
	PlayerTextDrawFont(playerid, PlayerInfo[playerid][CorridaPosInfo], 2);
	PlayerTextDrawLetterSize(playerid, PlayerInfo[playerid][CorridaPosInfo], 0.310000, 1.500000);
	PlayerTextDrawColor(playerid, PlayerInfo[playerid][CorridaPosInfo], -1);
	PlayerTextDrawSetOutline(playerid, PlayerInfo[playerid][CorridaPosInfo], 0);
	PlayerTextDrawSetProportional(playerid, PlayerInfo[playerid][CorridaPosInfo], 1);
	PlayerTextDrawSetShadow(playerid, PlayerInfo[playerid][CorridaPosInfo], 1);
	PlayerTextDrawSetSelectable(playerid, PlayerInfo[playerid][CorridaPosInfo], 0);
	return PlayerTextDrawShow(playerid, PlayerInfo[playerid][CorridaPosInfo]);
}
stock CriarDrawsCorrida(corridaid) {
	new str[100];
	Corridas[corridaid][CorridaDraws][0] = TextDrawCreate(83.000000, 261.000000, Corridas[corridaid][CorridaNome]);
	TextDrawAlignment(Corridas[corridaid][CorridaDraws][0], 2);
	TextDrawBackgroundColor(Corridas[corridaid][CorridaDraws][0], 255);
	TextDrawFont(Corridas[corridaid][CorridaDraws][0], 1);
	TextDrawLetterSize(Corridas[corridaid][CorridaDraws][0], 0.250000, 1.400000);
	TextDrawColor(Corridas[corridaid][CorridaDraws][0], -1);
	TextDrawSetOutline(Corridas[corridaid][CorridaDraws][0], 1);
	TextDrawSetProportional(Corridas[corridaid][CorridaDraws][0], 1);
	TextDrawUseBox(Corridas[corridaid][CorridaDraws][0], 1);
	TextDrawBoxColor(Corridas[corridaid][CorridaDraws][0], 64);
	TextDrawTextSize(Corridas[corridaid][CorridaDraws][0], 0.000000, 160.000000);
	TextDrawSetSelectable(Corridas[corridaid][CorridaDraws][0], 0);

	Corridas[corridaid][CorridaDraws][1] = TextDrawCreate(83.000000, 278.000000, "_");
	TextDrawAlignment(Corridas[corridaid][CorridaDraws][1], 2);
	TextDrawBackgroundColor(Corridas[corridaid][CorridaDraws][1], 255);
	TextDrawFont(Corridas[corridaid][CorridaDraws][1], 1);
	TextDrawLetterSize(Corridas[corridaid][CorridaDraws][1], 0.190000, 6.599999);
	TextDrawColor(Corridas[corridaid][CorridaDraws][1], -1);
	TextDrawSetOutline(Corridas[corridaid][CorridaDraws][1], 0);
	TextDrawSetProportional(Corridas[corridaid][CorridaDraws][1], 1);
	TextDrawSetShadow(Corridas[corridaid][CorridaDraws][1], 1);
	TextDrawUseBox(Corridas[corridaid][CorridaDraws][1], 1);
	TextDrawBoxColor(Corridas[corridaid][CorridaDraws][1], 96);
	TextDrawTextSize(Corridas[corridaid][CorridaDraws][1], 10.000000, 160.000000);
	TextDrawSetSelectable(Corridas[corridaid][CorridaDraws][1], 0);

	format(str, sizeof(str), "~w~Corrida Premio: ~g~R$~w~%i", Corridas[corridaid][CorridaPremio]);
	Corridas[corridaid][CorridaDraws][2] = TextDrawCreate(24.000000, 317.000000, str);
	TextDrawBackgroundColor(Corridas[corridaid][CorridaDraws][2], 255);
	TextDrawFont(Corridas[corridaid][CorridaDraws][2], 2);
	TextDrawLetterSize(Corridas[corridaid][CorridaDraws][2], 0.210000, 1.100000);
	TextDrawColor(Corridas[corridaid][CorridaDraws][2], -1);
	TextDrawSetOutline(Corridas[corridaid][CorridaDraws][2], 0);
	TextDrawSetProportional(Corridas[corridaid][CorridaDraws][2], 1);
	TextDrawSetShadow(Corridas[corridaid][CorridaDraws][2], 1);
	TextDrawSetSelectable(Corridas[corridaid][CorridaDraws][2], 0);

	Corridas[corridaid][CorridaDraws][3] = TextDrawCreate(140.000000, 287.000000, "0");
	TextDrawBackgroundColor(Corridas[corridaid][CorridaDraws][3], 255);
	TextDrawFont(Corridas[corridaid][CorridaDraws][3], 2);
	TextDrawLetterSize(Corridas[corridaid][CorridaDraws][3], 0.509999, 1.900000);
	TextDrawColor(Corridas[corridaid][CorridaDraws][3], -1);
	TextDrawSetOutline(Corridas[corridaid][CorridaDraws][3], 0);
	TextDrawSetProportional(Corridas[corridaid][CorridaDraws][3], 1);
	TextDrawSetShadow(Corridas[corridaid][CorridaDraws][3], 1);
	TextDrawSetSelectable(Corridas[corridaid][CorridaDraws][3], 0);
	return 1;
}
stock TerminarCorrida(corridaid) {
	for(new i; i < 4; i++)
		TextDrawDestroy(Corridas[corridaid][CorridaDraws][i]);
	for(new i; i < 3; i++)
	    Corridas[corridaid][InicioPos][i] = 0.0;
	for(new i; i < MAX_CHECKPOINTS; i++) {
		Corridas[corridaid][CheckpointX][i] = 0.0;
		Corridas[corridaid][CheckpointY][i] = 0.0;
		Corridas[corridaid][CheckpointZ][i] = 0.0;
		Corridas[corridaid][CorridaPosicao][i] = 0;
	}
	Corridas[corridaid][CorridaNome] = 0;
	Corridas[corridaid][CorridaTipo] = 0;
	Corridas[corridaid][CorridaPremio] = 0;
	Corridas[corridaid][CorridaID] = 0;
	Corridas[corridaid][CorridaRecord] = 0;
	Corridas[corridaid][CorridaVeiculo] = 0;
	Corridas[corridaid][MaxCheckpoints] = 0;
	Corridas[corridaid][CorridaMaxParticipantes] = 0;
	Corridas[corridaid][RecordBy] = 0;
	Corridas[corridaid][Iniciada] = false;
	Corridas[corridaid][Carregada] = false;
	Corridas[corridaid][EmProjeto] = false;
	Corridas[corridaid][InicioDefinido] = false;
	Corridas[corridaid][Trancada] = false;
	return 1;
}
stock GetPlayersCorrida(corridaid) {
	new Players = 0;
	for(new i; i <= GetMaxPlayers(); i++)
	    if(IsPlayerConnected(i) && PlayerInfo[i][CorridaID] == corridaid && PlayerInfo[i][EmCorrida] == true)
	        Players++;
	return Players;
}
forward IniciarCorrida(corridaid);
public IniciarCorrida(corridaid) {
	if(Corridas[corridaid][Carregada] == false) return 0;
	if(GetPlayersCorrida(corridaid) < 2) return Corridas[corridaid][CorridaTimerIniciar] = SetTimerEx("IniciarCorrida", 15000, false, "d", corridaid);
	Corridas[corridaid][Trancada] = true;
	for(new i; i <= GetMaxPlayers(); i++) {
		if(!IsPlayerConnected(i)) continue;
		if(PlayerInfo[i][CorridaID] == corridaid) {
			PlayerInfo[i][pCorridaPos] = 0;
			PlayerInfo[i][pCorridaCheckpoint] = 0;
			new c = corridaid;
			new p = 0;
			new t = Corridas[corridaid][CorridaTipo];
			if(p+1 < Corridas[c][MaxCheckpoints])
   				SetPlayerRaceCheckpoint(i, (t == CORRIDA_TERRESTRE) ? (0) : (3), Corridas[c][CheckpointX][p],Corridas[c][CheckpointY][p],Corridas[c][CheckpointZ][p], Corridas[c][CheckpointX][p+1], Corridas[c][CheckpointY][p+1], Corridas[c][CheckpointZ][p+1], 25.0);
    		else
    			SetPlayerRaceCheckpoint(i, (t == CORRIDA_TERRESTRE) ? (1) : (4), Corridas[c][CheckpointX][p],Corridas[c][CheckpointY][p],Corridas[c][CheckpointZ][p]+5.0, Corridas[c][CheckpointX][p+1], Corridas[c][CheckpointY][p+1], Corridas[c][CheckpointZ][p+1], 40.0);
			SetCameraBehindPlayer(i);
			TogglePlayerControllable(i, false);
			if(Corridas[corridaid][CorridaContagemSegundos] == 0)
			{
				Corridas[corridaid][CorridaContagemSegundos] = 3;
				Corridas[corridaid][CorridaTimerContagem] = SetTimerEx("IniciarCorrida_Contagem", 1000, true, "d", corridaid);
			}
			KillTimer(Corridas[corridaid][CorridaTimerIniciar]);
		}
	}
	return 1;
}
forward IniciarCorrida_Contagem(corridaid);
public IniciarCorrida_Contagem(corridaid) {
    new Msg[128];
	if(Corridas[corridaid][CorridaContagemSegundos] >= 1) {
  		format(Msg, 128, "~w~%i",Corridas[corridaid][CorridaContagemSegundos]);
		for(new i; i <= GetMaxPlayers(); i++)
		    if(IsPlayerConnected(i) && PlayerInfo[i][CorridaID] == corridaid) {
				GameTextForPlayer(i, Msg, 5000, 4);
                PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			}
		Corridas[corridaid][CorridaContagemSegundos] = Corridas[corridaid][CorridaContagemSegundos] - 1;
		return 1;
	}
	else {
		for(new i; i <= GetMaxPlayers(); i++)
			if(IsPlayerConnected(i) && PlayerInfo[i][CorridaID] == corridaid) {
				TogglePlayerControllable(i, true);
			    GameTextForPlayer(i, "~g~VAO!!", 5000, 4);
			    PlayerPlaySound(i, 3200, 0.0, 0.0, 0.0);
			}
		Corridas[corridaid][Iniciada] = true;
	}
	KillTimer(Corridas[corridaid][CorridaTimerContagem]);
	return 1;
}
/********************************
		    Comandos
*********************************/
CMD:espiar(playerid, params[]) {
	if(PlayerInfo[playerid][pLevel] < 1) return 0;
	new pID, Msg[144];
	if(sscanf(params, "u", pID)) return SendClientMessage(playerid, -1, "{ff0000}Use: /espiar [id/nome]");
	if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, -1, "{ff0000}Off!");
	TogglePlayerSpectating(playerid, true);
	PlayerSpectatePlayer(playerid, pID);
	PlayerInfo[playerid][pEspiando] = pID;
	format(Msg, 144, "{00ff00}* Você está espiando %s", PlayerInfo[pID][pNome]);
	SendClientMessage(playerid, -1, Msg);
	return 1;
}
CMD:pararespiar(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return 0;
	if(PlayerInfo[playerid][pEspiando] == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "{ff0000}Você não está espiando ninguém!");
	TogglePlayerSpectating(playerid, false);
	return 1;
}
CMD:criararea(playerid, params[]) {
	if(PlayerInfo[playerid][pLevel] < 4) return 0;
	new Msg[144], Float:Gz[4], Float:Ac[3], areaid, Query[300];
	if(sscanf(params, "p<,>fffffff", Gz[0], Gz[1], Gz[2], Gz[3], Ac[0], Ac[1], Ac[2])) return SendClientMessage(playerid, -1, "{ff0000}Use: /criararea [min x] [min y] [max x] [max y] [centro x] [centro y] [centro z]"), SendClientMessage(playerid, -1, "{ff0000}Você pode separar por vírgulas! ;)");
	for(areaid = 1; areaid < MAX_AREAS; areaid++)
	    if(Areas[areaid][Valida] == false) break; //Se não for válida, irá usar-la
	if(areaid >= MAX_AREAS) return SendClientMessage(playerid, -1, "{ff0000}Máximo de áreas atingido!");
	Areas[areaid][Valida] = true;
	Areas[areaid][GangZoneID] = GangZoneCreate(Gz[0], Gz[1], Gz[2], Gz[3]);
	GangZoneShowForAll(Areas[areaid][GangZoneID], COR_AREA);
	Areas[areaid][AreaID] = CreateDynamicRectangle(Gz[0], Gz[1], Gz[2], Gz[3]);
	Areas[areaid][Dominada] = false;
	Areas[areaid][EmAtaque] = false;
	format(Areas[areaid][AreaNome], 128, "");
	Areas[areaid][AreaGang] = 0;
	for(new i; i < 4; i++)
	    Areas[areaid][LocPos][i] = Gz[i];
	for(new i; i < 3; i++)
	    Areas[areaid][LocCentro][i] = Ac[i];
	Areas[areaid][AreaText] = CreateDynamic3DTextLabel("Área Neutra", COR_AREA, Ac[0], Ac[1], Ac[2], 20.0);
	format(Msg, 144, "{ffff00}Área %i criada!", areaid);
	SendClientMessage(playerid, -1, Msg);
	mysql_format(mysql, Query, sizeof(Query), "INSERT INTO areas (Localizacao,Centro) VALUES ('%4.2f,%4.2f,%4.2f,%4.2f','%4.2f,%4.2f,%4.2f')",Gz[0], Gz[1], Gz[2], Gz[3], Ac[0], Ac[1], Ac[2]);
	new Cache:Q = mysql_query(mysql, Query, true);
	Areas[areaid][ID_MySQL] = cache_insert_id(mysql);
	printf("Area %i registrada, id mysql %i", areaid,cache_insert_id(mysql));
	cache_delete(Q, mysql);
	return 1;
}
CMD:deletararea(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] < 4) return 0;
	new Msg[144], areaid, Query[200];
	if(sscanf(params, "i", areaid)) return SendClientMessage(playerid, -1, "{ff0000}Use: /deletararea [area id]");
	if(areaid <= 0 || areaid >= MAX_AREAS) return SendClientMessage(playerid, -1, "{ff0000}Área inválida!");
	if(Areas[areaid][Valida] != true) return SendClientMessage(playerid, -1, "{ff0000}Àrea inválida!");
	Areas[areaid][Valida] = false;
	GangZoneDestroy(Areas[areaid][GangZoneID]);
	DestroyDynamicArea(Areas[areaid][AreaID]);
	Areas[areaid][Dominada] = false;
	Areas[areaid][EmAtaque] = false;
	format(Areas[areaid][AreaNome], 128, "");
	Areas[areaid][AreaGang] = 0;
	for(new i; i < 4; i++)
	    Areas[areaid][LocPos][i] = 0.0;
	for(new i; i < 3; i++)
	    Areas[areaid][LocCentro][i] = 0.0;
	mysql_format(mysql, Query, sizeof(Query), "DELETE FROM areas WHERE id=%i", Areas[areaid][ID_MySQL]);
	mysql_query(mysql, Query, false);
	format(Msg, 144, "{ffff00}Àrea %i deletada com sucesso!", areaid);
	SendClientMessage(playerid, -1, Msg);
	return 1;
}

CMD:criargang(playerid, params[]) {
	if(PlayerInfo[playerid][pGang] != 0) return SendClientMessage(playerid, -1, "{ff0000}Você já faz parte de uma gang!");
	return ShowPlayerDialog(playerid, DialogCriarGang, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}MF - Crie sua gang!", "{ffffff}Digite o nome de sua gang:", "Ok", "Cancelar");
}
CMD:gangmenu(playerid, parmas[]) {
	if(PlayerInfo[playerid][pGang] == 0) return SendClientMessage(playerid, -1, "{ff0000}Você não faz parte de alguma gang!");
	return MenuGang(playerid);
}
CMD:menugang(playerid, params[]) return cmd_gangmenu(playerid, params);

CMD:aceitargang(playerid, params[]) {
	if(PlayerInfo[playerid][pGang] != 0) return SendClientMessage(playerid, -1, "{ff0000}Você já faz parte de uma gang!");
	if(PlayerInfo[playerid][pConviteGang] == 0) return SendClientMessage(playerid, -1, "{ff0000}Você não foi convidado para uma gang!");
	PlayerInfo[playerid][pGang] = PlayerInfo[playerid][pConviteGang];
	SendClientMessage(playerid, -1, "{ffff00}Você entrou na gang!");
	SalvarConta(playerid);
	PlayerInfo[playerid][pConviteGang] = 0;
	for(new i; i < MAX_GANG_MEMBROS; i++) {
		if(Gangs[PlayerInfo[playerid][pGang]][GangMembros][i] == 0) {
            Gangs[PlayerInfo[playerid][pGang]][GangMembros][i] = PlayerInfo[playerid][pMySQL_ID];
			break;
		}
	}
	new Query[300], LM[200];
	for(new i; i < MAX_GANG_MEMBROS; i++) {
		if(Gangs[PlayerInfo[playerid][pGang]][GangMembros][i] == 0) continue;
		format(LM, sizeof(LM), "%s%i,", LM,Gangs[PlayerInfo[playerid][pGang]][GangMembros][i]);
	}
	format(Query, sizeof(Query), "UPDATE gangs SET Membros='%s' WHERE id=%i", LM, Gangs[PlayerInfo[playerid][pGang]][ID_MySQL]);
	mysql_query(mysql, Query, false);
	return 1;
}
CMD:recusargang(playerid, params[]) {
	if(PlayerInfo[playerid][pGang] != 0) return SendClientMessage(playerid, -1, "{ff0000}Você já faz parte de uma gang!");
	if(PlayerInfo[playerid][pConviteGang] == 0) return SendClientMessage(playerid, -1, "{ff0000}Você não foi convidado para uma gang!");
	PlayerInfo[playerid][pConviteGang] = 0;
	SendClientMessage(playerid, -1, "{ff0000}Você recusou o convite da gang!");
	return 1;
}
CMD:gangs(playerid, params[]) {
    TodasGangs(playerid);
    return 1;
}
CMD:dominar(playerid, parmas[]) {
    if(PlayerInfo[playerid][pGang] == 0) return SendClientMessage(playerid, -1, "{ff0000}Você não faz parte de nenhuma gang!");
	if(GetPVarInt(playerid, "dominar_area") != 0) return SendClientMessage(playerid, -1, "{ff0000}Você está dominando uma área!");
	new areaid;
	for(areaid = 1; areaid < MAX_AREAS; areaid++) {
		if(Areas[areaid][Valida] == false) continue;
		if(!IsPlayerInDynamicArea(playerid, Areas[areaid][AreaID], true)) continue;
		if(Areas[areaid][AreaGang] == PlayerInfo[playerid][pGang]) continue;
		SetPVarInt(playerid, "dominar_area", areaid);
		SetPVarInt(playerid, "tempo_dominacao", 30);
		SetTimerEx("DominandoArea", 1000, false, "d", playerid);
		Areas[areaid][EmAtaque] = true;
		GangZoneFlashForAll(Areas[areaid][GangZoneID], Gangs[PlayerInfo[playerid][pGang]][GangCor]);
		return SendClientMessage(playerid, -1, "{ff0000}Você está dominando a área!");
	}
	SendClientMessage(playerid, -1, "{ff0000}Você não está em uma área!");
    return 1;
}
forward DominandoArea(playerid);
public DominandoArea(playerid) {
	new areaid = GetPVarInt(playerid, "dominar_area"), string[200];
	if(GetPVarInt(playerid, "dominar_area") == 0) return 1;
	if(Areas[areaid][AreaGang] == PlayerInfo[playerid][pGang]) {
		DeletePVar(playerid, "tempo_dominacao");
		DeletePVar(playerid, "dominar_area");
		SendClientMessage(playerid, -1, "{ff0000}Esta área já é de sua gang!");
		GangZoneStopFlashForAll(Areas[areaid][GangZoneID]);
		Areas[areaid][EmAtaque] = false;
		return 1;
	}
	if(GetPVarInt(playerid, "tempo_dominacao") > 0) {
		Areas[areaid][EmAtaque] = true;
		format(string, sizeof(string), "~w~Tempo restante: ~r~%i", GetPVarInt(playerid, "tempo_dominacao"));
		GameTextForPlayer(playerid, string, 5000, 3);
		SetPVarInt(playerid, "tempo_dominacao",GetPVarInt(playerid, "tempo_dominacao")-1);
		SetTimerEx("DominandoArea", 1000, false, "d", playerid);
	}
	else {
		Areas[areaid][EmAtaque] = false;
		Areas[areaid][Dominada] = true;
		Areas[areaid][AreaGang] = PlayerInfo[playerid][pGang];
		for(new i = 0; i < MAX_GANG_AREAS; i++) {
			if(Gangs[PlayerInfo[playerid][pGang]][GangAreas][i] != 0) continue;
			Gangs[PlayerInfo[playerid][pGang]][GangAreas][i] = areaid;
			break;
		}
		GameTextForPlayer(playerid, "~g~Area dominada!", 5000, 3);
		new Query[300];
		for(new i; i < MAX_GANG_AREAS; i++) {
		    if(Gangs[PlayerInfo[playerid][pGang]][GangAreas][i] == 0) continue;
		    format(string, sizeof(string), "%s%i,", string,Gangs[PlayerInfo[playerid][pGang]][GangAreas][i]);
		}
		mysql_format(mysql, Query, sizeof(Query), "UPDATE gangs SET Areas='%s' WHERE id=%i", string, Gangs[PlayerInfo[playerid][pGang]][ID_MySQL]);
		mysql_query(mysql, Query, false);
		mysql_format(mysql, Query, sizeof(Query), "UPDATE areas SET Gang=%i WHERE id=%i", PlayerInfo[playerid][pGang], Areas[areaid][ID_MySQL]);
		mysql_query(mysql, Query, false);
		GangZoneStopFlashForAll(Areas[areaid][GangZoneID]);
		GangZoneShowForAll(Areas[areaid][GangZoneID], Gangs[PlayerInfo[playerid][pGang]][GangCor]);
		ShowPlayerDialog(playerid, DialogGangAreaNome, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}Nome da área!", "Digite o nome da área", "Definir", "");
		DeletePVar(playerid, "tempo_dominacao");
		format(string, sizeof(string), "Gang: %s\nDescrição: %s\n", Gangs[PlayerInfo[playerid][pGang]][GangNome], Gangs[PlayerInfo[playerid][pGang]][GangDescricao]);
		UpdateDynamic3DTextLabelText(Areas[areaid][AreaText], Gangs[PlayerInfo[playerid][pGang]][GangCor], string);
	}
	return 1;
}
CMD:mostrardano(playerid, params[]) {
	PlayerInfo[playerid][MostrarDano] = (PlayerInfo[playerid][MostrarDano] == true) ? (false) : (true);
	SendClientMessage(playerid, -1, (PlayerInfo[playerid][MostrarDano] == true) ? ("{ffff00}Seu dano agora será exibido no canto da tela!") : ("{ff0000}Você desabilitou a exibição de dano!"));
	if(PlayerInfo[playerid][MostrarDano] == false)
	{
		for(new i; i < 9; i++)
		    PlayerTextDrawHide(playerid, PlayerInfo[playerid][PlayerDano][i]);
	}
	else
    {
		PlayerTextDrawSetPreviewModel(playerid, PlayerInfo[playerid][PlayerDano][1], GetPlayerSkin(playerid));
		for(new i; i < 2; i++)
		    PlayerTextDrawShow(playerid, PlayerInfo[playerid][PlayerDano][i]);
	}
	return 1;
}
CMD:carregarcorrida(playerid, params[]) {
	if(PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid, -1, "{EE00EE}* Você não tem level suficiente para isso!");
	new Dialog[2000], Cache:TCorridas = mysql_query(mysql, "SELECT * FROM corridas ORDER BY ID DESC", true);
	if(cache_num_rows(mysql) > 0) {
	    for(new i; i < cache_num_rows(mysql); i++) {
			new NomeCorrida[128], Premio = cache_get_field_content_int(i, "CorridaPremio", mysql);
			cache_get_field_content(i, "CorridaNome", NomeCorrida, mysql, 128);
			format(Dialog, sizeof(Dialog), "%s%s - R$%i\r\n", Dialog, NomeCorrida, Premio);
		}
		ShowPlayerDialog(playerid, DialogCorridas, DIALOG_STYLE_LIST, "{ff0000}# {ffffff}Corridas!", Dialog, "Selecionar", "Cancelar");
	}
	else
	    SendClientMessage(playerid, -1, "{ff0000}Nenhuma corrida encontrada!");
	cache_delete(TCorridas, mysql);
	return 1;
}
CMD:criarcorrida(playerid, params[]) {
	if(PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid, -1, "{EE00EE}* Você não tem level suficiente para isso!");
	new Nome[128], Premio, Veiculo, Tipo, MaxParticipantes, Msg[144], corridaid;
	if(sscanf(params, "iiiis[128]", Premio, Veiculo, MaxParticipantes, Tipo, Nome)) return SendClientMessage(playerid, -1, "{ff0000}* Use: /criarcorrida [premio] [veiculo (0 para variado)] [maximo de participantes] [tipo (1 = TERRESTE | 2 = AEREA)] [nome da corrida]");
	if(Tipo != CORRIDA_AEREA && Tipo != CORRIDA_TERRESTRE) return SendClientMessage(playerid, -1, "{ff0000}Tipo de corrida inválido!");
	for(corridaid = 1; corridaid < MAX_CORRIDAS; corridaid++) {
	    if(Corridas[corridaid][EmProjeto] == true) continue;
	    if(Corridas[corridaid][Carregada] == true) continue;
		break; //no caso, se não houver carregadas nem em projeto.
	}
	if(corridaid == MAX_CORRIDAS) return SendClientMessage(playerid, -1, "{ff0000}Máximo de corridas atingido!");
	Corridas[corridaid][EmProjeto] = true;
	Corridas[corridaid][Trancada] = true;
	Corridas[corridaid][Carregada] = false;
	Corridas[corridaid][InicioDefinido] = false;
	Corridas[corridaid][CorridaTipo] = Tipo;
	Corridas[corridaid][CorridaPremio] = Premio;
	Corridas[corridaid][CorridaVeiculo] = Veiculo;
	Corridas[corridaid][CorridaMaxParticipantes] = MaxParticipantes;
	format(Corridas[corridaid][CorridaNome], 128, Nome);
	format(Msg, 144, "{ffff00}* [CORRIDA] Projeto %s iniciado! Use /criarcheckpoint para criar checkpoints e /corridainicio para definir o incio da corrida!", Nome);
	SendClientMessage(playerid, -1, Msg);
	SetPlayerVirtualWorld(playerid, corridaid + 10);
	PlayerInfo[playerid][CorridaID] = corridaid;
	PlayerInfo[playerid][EmCorrida] = true;
	if(Veiculo != 0 && Veiculo != GetVehicleModel(GetPlayerVehicleID(playerid))) {
		new Float:Pos[4], vid;
		GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
		GetPlayerFacingAngle(playerid, Pos[3]);
		vid = PlayerInfo[playerid][pCorridaVeh] = CreateVehicle(Veiculo, Pos[0], Pos[1], Pos[2], Pos[3], random(255), random(255), 60);
		SetVehicleVirtualWorld(vid, corridaid + 10);
		PutPlayerInVehicle(playerid, vid, 0);
	}
	else {
		if(GetPlayerVehicleSeat(playerid) == 0)
		    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), corridaid+10);
	}
	return 1;
}
CMD:corridainicio(playerid, params[]) {
   	if(PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid, -1, "{EE00EE}* Você não tem level suficiente para isso!");
	if(PlayerInfo[playerid][CorridaID] == 0) return SendClientMessage(playerid, -1, "{ff0000}* Você deve estar em uma corrida em projeto!");
	if(Corridas[PlayerInfo[playerid][CorridaID]][EmProjeto] == false) return SendClientMessage(playerid, -1, "{ff0000}Esta corrida não está em projeto!");
	new Float:Pos[3];
	if(GetPlayerVehicleID(playerid) == 0)
		GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	else
	    GetVehiclePos(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
	Corridas[PlayerInfo[playerid][CorridaID]][InicioDefinido] = true;
	for(new i; i < 3; i++)
	    Corridas[PlayerInfo[playerid][CorridaID]][InicioPos][i] = Pos[i];
	SendClientMessage(playerid, -1, "{ffff00}* Início da corrida definido!");
	return 1;
}
CMD:criarcheckpoint(playerid, params[])
{
   	if(PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid, -1, "{EE00EE}* Você não tem level suficiente para isso!");
	if(PlayerInfo[playerid][CorridaID] == 0) return SendClientMessage(playerid, -1, "{ff0000}* Você deve estar em uma corrida em projeto!");
	if(Corridas[PlayerInfo[playerid][CorridaID]][EmProjeto] == false) return SendClientMessage(playerid, -1, "{ff0000}Esta corrida não está em projeto!");
	if(Corridas[PlayerInfo[playerid][CorridaID]][InicioDefinido] == false) return SendClientMessage(playerid, -1, "{ff0000}Você deve definir o início da corrida!");
	if(Corridas[PlayerInfo[playerid][CorridaID]][MaxCheckpoints] >= MAX_CHECKPOINTS) return SendClientMessage(playerid, -1, "{ff0000}Máximo de checkpoints atingido!");
	new Float:Pos[3], Msg[144], Checkpoint = Corridas[PlayerInfo[playerid][CorridaID]][MaxCheckpoints];
	if(GetPlayerVehicleID(playerid) == 0)
		GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	else
	    GetVehiclePos(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
	Corridas[PlayerInfo[playerid][CorridaID]][CheckpointX][Checkpoint] = Pos[0];
	Corridas[PlayerInfo[playerid][CorridaID]][CheckpointY][Checkpoint] = Pos[1];
	Corridas[PlayerInfo[playerid][CorridaID]][CheckpointZ][Checkpoint] = Pos[2];
	Corridas[PlayerInfo[playerid][CorridaID]][MaxCheckpoints]++;
	format(Msg, 144, "{ffff00}* Checkpoint criado! %i/%i", Checkpoint+1, MAX_CHECKPOINTS);
	SendClientMessage(playerid, -1, Msg);
	return 1;
}
CMD:terminarcorrida(playerid, params[]) {
	if(PlayerInfo[playerid][pLevel] >= 3 && PlayerInfo[playerid][CorridaID] != 0 && Corridas[PlayerInfo[playerid][CorridaID]][EmProjeto] == true) {
		if(Corridas[PlayerInfo[playerid][CorridaID]][InicioDefinido] == false) return SendClientMessage(playerid, -1, "{ff0000}Você não definiu o início da corrida!");
		new Query[2000], CX[300], CY[300], CZ[300], corridaid = PlayerInfo[playerid][CorridaID];
		for(new i; i < Corridas[corridaid][MaxCheckpoints]; i++)
		{
			format(CX, sizeof(CX), "%s%4.2f,", CX, Corridas[corridaid][CheckpointX][i]);
			format(CY, sizeof(CY), "%s%4.2f,", CY, Corridas[corridaid][CheckpointY][i]);
			format(CZ, sizeof(CZ), "%s%4.2f,", CZ, Corridas[corridaid][CheckpointZ][i]);
		}
		mysql_format(mysql, Query, sizeof(Query),"INSERT INTO corridas (CorridaNome,CorridaTipo,CorridaPremio,CheckpointsX,CheckpointsY,CheckpointsZ,InicioX,InicioY,InicioZ,MaximoParticipantes,Veiculo,MaxCheckpoints) VALUES ('%e',%i,%i,'%s','%s','%s',%4.2f,%4.2f,%4.2f,%i,%i,%i)", Corridas[corridaid][CorridaNome], Corridas[corridaid][CorridaTipo],
 		Corridas[corridaid][CorridaPremio],CX,CY,CZ,Corridas[corridaid][InicioPos][0],Corridas[corridaid][InicioPos][1],Corridas[corridaid][InicioPos][2],Corridas[corridaid][CorridaMaxParticipantes],Corridas[corridaid][CorridaVeiculo],Corridas[corridaid][MaxCheckpoints]);
        mysql_query(mysql, Query, false);

		SetPlayerVirtualWorld(playerid, 0);
		if(GetPlayerVehicleSeat(playerid) == 0)
			SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
        PlayerInfo[playerid][CorridaID] = 0;
		PlayerInfo[playerid][EmCorrida] = false;
		if(PlayerInfo[playerid][pCorridaVeh] != 0) {
			DestroyVehicle(PlayerInfo[playerid][pCorridaVeh]);
			PlayerInfo[playerid][pCorridaVeh] = 0;
		}
		for(new i; i < MAX_CHECKPOINTS; i++) {
			Corridas[corridaid][CheckpointX][i] = 0.0;
			Corridas[corridaid][CheckpointY][i] = 0.0;
			Corridas[corridaid][CheckpointZ][i] = 0.0;
		}
		Corridas[corridaid][MaxCheckpoints] = 0;
		Corridas[corridaid][CorridaPremio] = 0;
		Corridas[corridaid][CorridaVeiculo] = 0;
		Corridas[corridaid][CorridaNome] = 0;
		Corridas[corridaid][CorridaMaxParticipantes] = 0;
		for(new i; i < 3; i++)
		    Corridas[corridaid][InicioPos][i] = 0.0;
		Corridas[corridaid][EmProjeto] = false;
		Corridas[corridaid][Trancada] = false;
		Corridas[corridaid][InicioDefinido] = false;
		Corridas[corridaid][Carregada] = false;
		Corridas[corridaid][CorridaTipo] = 0;
        SendClientMessage(playerid, -1, "{ffff00}Projeto salvo!");
		return 1; //Aqui é para finalizar um projeto de corrida.
	}
	new corridaid, Msg[144];
	if(sscanf(params, "i", corridaid)) return SendClientMessage(playerid, -1, "{ff0000}Use: /terminarcorrida [corrida id]");
	if(corridaid <= 0 || corridaid >= MAX_CORRIDAS) return SendClientMessage(playerid, -1, "{ff0000}Corrida inválida!");
	if(Corridas[corridaid][EmProjeto] == true) return SendClientMessage(playerid, -1, "{ff0000}Esta corrida está em projeto, apenas quem estiver criando pode termina-la!");
	if(Corridas[corridaid][Carregada] == false) return SendClientMessage(playerid, -1, "{ff0000}Esta corrida não foi carregada!");
	for(new i; i <= GetMaxPlayers(); i++)
	{
		if(!IsPlayerConnected(i)) continue;
		if(PlayerInfo[i][EmCorrida] == true && PlayerInfo[i][CorridaID] == corridaid)
		{
			DisablePlayerCheckpoint(i);
			DisablePlayerRaceCheckpoint(i);
			PlayerInfo[i][EmCorrida] = false;
			PlayerInfo[i][CorridaID] = 0;
			SetPlayerVirtualWorld(i, 0);
			PlayerTextDrawDestroy(i, PlayerInfo[i][CorridaPosInfo]);
			if(GetPlayerVehicleSeat(i) == 0)
			    SetVehicleVirtualWorld(GetPlayerVehicleID(i), 0);
			if(PlayerInfo[i][pCorridaVeh] != 0)
			{
				DestroyVehicle(PlayerInfo[i][pCorridaVeh]);
				PlayerInfo[i][pCorridaVeh] = 0;
			}
		}
	}
	format(Msg, 144, "{ffff00}[CORRIDA] * %s terminou a corrida %s", PlayerInfo[playerid][pNome], Corridas[corridaid][CorridaNome]);
	SendClientMessageToAll(-1, Msg);
	TerminarCorrida(corridaid);
	return 1;
}
CMD:ircorrida(playerid, params[]) {
	if(PlayerInfo[playerid][EmCorrida] == true) return SendClientMessage(playerid, -1, "{EE00EE}* Você já está em uma corrida!");
	new corridaid, Msg[144];
	if(sscanf(params, "i", corridaid)) return SendClientMessage(playerid, -1, "{ff0000}* Use: /ircorrida [id da corrida desejada]");
	if(corridaid <= 0 || corridaid >= MAX_CORRIDAS) return SendClientMessage(playerid, -1, "{ff0000}* Corrida inválida!");
	if(Corridas[corridaid][Carregada] == false) return SendClientMessage(playerid, -1, "{ff0000}Corrida não carregada!");
	if(Corridas[corridaid][Trancada] == true || Corridas[corridaid][Iniciada]) return SendClientMessage(playerid, -1, "{ff0000}Você não pode entrar mais entrar nesta corrida!");
	if(GetPlayerVehicleID(playerid) == 0 && Corridas[corridaid][CorridaVeiculo] == 0) return SendClientMessage(playerid, -1, "{ff0000}Nesta corrida é necessária você estar com um veículo!");
	if(GetPlayersCorrida(corridaid) >= Corridas[corridaid][CorridaMaxParticipantes]) return SendClientMessage(playerid, -1, "{ff0000}Esta corrida já está em seu limite de participantes!");
	CriarDrawsCorridaParaPlayer(playerid);
	for(new i; i < 4; i++)
	    TextDrawShowForPlayer(playerid, Corridas[corridaid][CorridaDraws][i]);
	PlayerInfo[playerid][CorridaID] = corridaid;
	PlayerInfo[playerid][EmCorrida] = true;
	new vehicleid = GetPlayerVehicleID(playerid);
	SetPlayerVirtualWorld(playerid, corridaid + 10);
	SetPlayerPos(playerid,Corridas[corridaid][InicioPos][0],Corridas[corridaid][InicioPos][1],Corridas[corridaid][InicioPos][2]+2.0);
	if(GetPlayerVehicleSeat(playerid) == 0) {
	    if(Corridas[corridaid][CorridaVeiculo] == GetVehicleModel(GetPlayerVehicleID(playerid)) && Corridas[corridaid][CorridaVeiculo] != 0) {
			SetVehicleVirtualWorld(vehicleid, corridaid+10);
			SetVehiclePos(vehicleid, Corridas[corridaid][InicioPos][0],Corridas[corridaid][InicioPos][1],Corridas[corridaid][InicioPos][2]);
			PutPlayerInVehicle(playerid, vehicleid, 0);
		}
		else if(Corridas[corridaid][CorridaVeiculo] == 0){
			SetVehicleVirtualWorld(vehicleid, corridaid+10);
			SetVehiclePos(vehicleid, Corridas[corridaid][InicioPos][0],Corridas[corridaid][InicioPos][1],Corridas[corridaid][InicioPos][2]);
			PutPlayerInVehicle(playerid, vehicleid, 0);
		}
	} else if(Corridas[corridaid][CorridaVeiculo] != 0) {
		new vid = CreateVehicle(Corridas[corridaid][CorridaVeiculo], Corridas[corridaid][InicioPos][0],Corridas[corridaid][InicioPos][1],Corridas[corridaid][InicioPos][2], 90.0, random(255), random(255), 60);
		SetVehicleVirtualWorld(vid, corridaid + 10);
        PutPlayerInVehicle(playerid, vid, 0);
		SetVehicleParamsEx(vid, 1, 1, 0, 1, 0, 0, 0);
        PlayerInfo[playerid][pCorridaVeh] = vid;
	}
	format(Msg, 144, "{ffff00}[CORRIDA] * %s foi a corrida %s", PlayerInfo[playerid][pNome], Corridas[corridaid][CorridaNome]);
	SendClientMessageToAll(-1, Msg);
	return 1;
}
CMD:saircorrida(playerid, params[]) {
	if(PlayerInfo[playerid][EmCorrida] == false) return SendClientMessage(playerid, -1, "{EE00EE}* Você não está em uma corrida!");
	TogglePlayerControllable(playerid, true);
	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	if(GetPlayerVehicleID(playerid) != 0)
	    SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), 0);
	if(PlayerInfo[playerid][pCorridaVeh] != 0)
	{
		DestroyVehicle(PlayerInfo[playerid][pCorridaVeh]);
		PlayerInfo[playerid][pCorridaVeh] = 0;
	}
	PlayerTextDrawDestroy(playerid, PlayerInfo[playerid][CorridaPosInfo]);
	PlayerInfo[playerid][pCorridaPos] = 0;
	for(new i; i < 4; i++)
		TextDrawHideForPlayer(playerid, Corridas[PlayerInfo[playerid][CorridaID]][CorridaDraws][i]);
	PlayerInfo[playerid][EmCorrida] = false;
	PlayerInfo[playerid][CorridaID] = 0;
	SendClientMessage(playerid, -1, "{ff0000}* Você saiu da corrida! :/");
	return 1;
}
CMD:para(playerid, params [])
{
	GivePlayerWeapon(playerid,46,1);
 	SendClientMessage(playerid, -1, "{ff0000}* Você recebeu um paraquedas!");
  	return 1;
}

CMD:teles(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{EE00EE}* Não é possivel teleportar em uma arena, use /sairarena.");
    new Dialog[2000];
    for(new i; i < sizeof(TeleTipo); i++) {
        format(Dialog, sizeof(Dialog), "%s%s\r\n", Dialog, TeleTipo[i]);
    }
    ShowPlayerDialog(playerid, DialogTeleportLista, DIALOG_STYLE_LIST, "{ff0000}# {ffffff}Teleportes", Dialog, "Escolher", "Cancelar");
    return 1;
}
CMD:stunts(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{7B68EE}* Você está em uma arena, use /sairarena.");
    new Msg1[2000], Msg2[128], Disponiveis;
    for(new i; i < sizeof(Teleportes); i++) {
        if(Teleportes[i][teleTipo] != Tele_Stunt) continue;
        Disponiveis++;
        format(Msg1, sizeof(Msg1), "%s%s (/%s)\r\n", Msg1, Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
    }
    format(Msg2, sizeof(Msg2), "{ff0000}# {ffffff}%i Teleportes de Stunt", Disponiveis);
    ShowPlayerDialog(playerid, DialogTeleStunt, DIALOG_STYLE_LIST, Msg2, Msg1, "Escolher", "Cancelar");
    return 1;
}
CMD:reparar(playerid, params[]) {
	if(GetPlayerVehicleSeat(playerid) != 0) return SendClientMessage(playerid, -1, "{ff0000}Você deve estar conduzindo um veículo!");
	RepairVehicle(GetPlayerVehicleID(playerid));
	return GameTextForPlayer(playerid, "~r~Reparado~w~!", 5000, 3);
}
CMD:pistas(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{7B68EE}* Você está em uma arena, use /sairarena.");
    new Msg1[2000], Msg2[128], Disponiveis;
    for(new i; i < sizeof(Teleportes); i++) {
        if(Teleportes[i][teleTipo] != Tele_Pistas) continue;
        Disponiveis++;
        format(Msg1, sizeof(Msg1), "%s%s (/%s)\r\n", Msg1, Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
    }
    format(Msg2, sizeof(Msg2), "{ff0000}# {ffffff}%i Teleportes", Disponiveis);
    ShowPlayerDialog(playerid, DialogTelePistas, DIALOG_STYLE_LIST, Msg2, Msg1, "Escolher", "Cancelar");
    return 1;
}
CMD:drift(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{7B68EE}* Você está em uma arena, use /sairarena.");
    new Msg1[2000], Msg2[128], Disponiveis;
    for(new i; i < sizeof(Teleportes); i++) {
        if(Teleportes[i][teleTipo] != Tele_Drift) continue;
        Disponiveis++;
        format(Msg1, sizeof(Msg1), "%s%s (/%s)\r\n", Msg1, Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
    }
    format(Msg2, sizeof(Msg2), "{ff0000}# {ffffff}%i Teleportes de Drift", Disponiveis);
    ShowPlayerDialog(playerid, DialogTeleDrift, DIALOG_STYLE_LIST, Msg2, Msg1, "Escolher", "Cancelar");
    return 1;
}
CMD:pulos(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{7B68EE}* Você está em uma arena, use /sairarena.");
    new Msg1[2000], Msg2[128], Disponiveis;
    for(new i; i < sizeof(Teleportes); i++) {
        if(Teleportes[i][teleTipo] != Tele_Pulos) continue;
        Disponiveis++;
        format(Msg1, sizeof(Msg1), "%s%s (/%s)\r\n", Msg1, Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
    }
    format(Msg2, sizeof(Msg2), "{ff0000}# {ffffff}%i Teleportes", Disponiveis);
    ShowPlayerDialog(playerid, DialogTelePulos, DIALOG_STYLE_LIST, Msg2, Msg1, "Escolher", "Cancelar");
    return 1;
}
CMD:corridas(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{7B68EE}* Você está em uma arena, use /sairarena.");
    new Msg1[2000], Msg2[128], Disponiveis;
    for(new i; i < sizeof(Teleportes); i++) {
        if(Teleportes[i][teleTipo] != Tele_Corrida) continue;
        Disponiveis++;
        format(Msg1, sizeof(Msg1), "%s%s (/%s)\r\n", Msg1, Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
    }
    format(Msg2, sizeof(Msg2), "{ff0000}# {ffffff}%i Corridas", Disponiveis);
    ShowPlayerDialog(playerid, DialogTeleCorridas, DIALOG_STYLE_LIST, Msg2, Msg1, "Escolher", "Cancelar");
    return 1;
}
CMD:tubos(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{7B68EE}* Você está em uma arena, use /sairarena.");
    new Msg1[2000], Msg2[128], Disponiveis;
    for(new i; i < sizeof(Teleportes); i++) {
        if(Teleportes[i][teleTipo] != Tele_Tubos) continue;
        Disponiveis++;
        format(Msg1, sizeof(Msg1), "%s%s (/%s)\r\n", Msg1, Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
    }
    format(Msg2, sizeof(Msg2), "{ff0000}# {ffffff}%i Teleportes", Disponiveis);
    ShowPlayerDialog(playerid, DialogTeleTubos, DIALOG_STYLE_LIST, Msg2, Msg1, "Escolher", "Cancelar");
    return 1;
}
CMD:varios(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{7B68EE}* Você está em uma arena, use /sairarena.");
    new Msg1[2000], Msg2[128], Disponiveis;
    for(new i; i < sizeof(Teleportes); i++) {
        if(Teleportes[i][teleTipo] != Tele_Variados) continue;
        Disponiveis++;
        format(Msg1, sizeof(Msg1), "%s%s (/%s)\r\n", Msg1, Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
    }
    format(Msg2, sizeof(Msg2), "{ff0000}# {ffffff}%i Teleportes Variados", Disponiveis);
    ShowPlayerDialog(playerid, DialogTeleVariado, DIALOG_STYLE_LIST, Msg2, Msg1, "Escolher", "Cancelar");
    return 1;
}
CMD:tlnormal(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{7B68EE}* Você está em uma arena, use /sairarena.");
    new Msg1[2000], Msg2[128], Disponiveis;
    for(new i; i < sizeof(Teleportes); i++) {
        if(Teleportes[i][teleTipo] != Tele_Normal) continue;
        Disponiveis++;
        format(Msg1, sizeof(Msg1), "%s%s (/%s)\r\n", Msg1, Teleportes[i][teleportNome], Teleportes[i][TeleCmd]);
    }
    format(Msg2, sizeof(Msg2), "{ff0000}# {ffffff}%i Teleportes Normais", Disponiveis);
    ShowPlayerDialog(playerid, DialogTeleNormal, DIALOG_STYLE_LIST, Msg2, Msg1, "Escolher", "Cancelar");
    return 1;
}
CMD:email(playerid, params[]) {
	new Email[128];
	if(sscanf(params, "s[128]", Email)) return SendClientMessage(playerid, -1, "{ff0000}Use: /email [seu e-mail]");
	if(strfind(Email, "@", true) == -1) return SendClientMessage(playerid, -1, "{ff0000}O E-mail digitado é inválido.");
	format(PlayerInfo[playerid][pEmail], 128, Email);
	new Msg[144];
	format(Msg, 144, "{a9c4e4}E-mail definido: {ffffff}%s", Email);
	ShowPlayerDialog(playerid, DialogSemResposta, DIALOG_STYLE_MSGBOX, "{ffff00}# {ffffff}Email", Msg, "Fechar", "");
	return SalvarConta(playerid);
}
CMD:morrer(playerid, params[]) {
    PlayerInfo[playerid][Morrer] = true;
    SetPlayerHealth(playerid, 0.0);
    return 1;
}
CMD:skin(playerid, params[]) {
    ShowModelSelectionMenu(playerid, SKIN_LISTA, "Skin");
    return 1;
}
CMD:local(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] == 0) return SendClientMessage(playerid, -1, "{ff0000}Comando de administrador!");
    new Float:p[4], Msg[144];
    GetPlayerPos(playerid, p[0], p[1], p[2]);
    if(GetPlayerVehicleID(playerid) == 0)
        GetPlayerFacingAngle(playerid, p[3]);
    else
        GetVehicleZAngle(GetPlayerVehicleID(playerid), p[3]);
    format(Msg, 144, "{ffff00}X: %4.2f, Y: %4.2f, Z: %4.2f, Rotação: %4.2f, Interior: %i, Mundo: %i", p[0], p[1], p[2], p[3], GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
    SendClientMessage(playerid, -1, Msg);
    return 1;
}
CMD:equipe(playerid, params[]) {
    new Msg[300];
    format(Msg, sizeof(Msg), "{a9c4e4}Créditos à Equipe Mega Freeroam\n\n{ffffff}NicK{a9c4e4} - Desenvolvedor do Gamemode.\n{ffffff}Delete{a9c4e4} - Apoio de script/mapas.\n\n{ffffff}%s {a9c4e4}- por jogar em nosso servidor.", PlayerInfo[playerid][pNome]);
    ShowPlayerDialog(playerid, DialogSemResposta, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Equipe", Msg, "Ok", "");
    return 1;
}
CMD:v(playerid, params[]) {
	if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{ff0000}Você não pode criar veiculos dentro de uma arena!");
    new Msg[256];
    format(Msg, sizeof(Msg), "Motos\r\nBarcos\r\nConversíveis\r\nHelicopteros\r\nIndustrial\r\nLow Rider\r\nOff-Road\r\nAviões\r\nPúblicos\r\nSalão\r\nSport\r\nTrailers\r\nÚnicos\r\nBásicos");
    ShowPlayerDialog(playerid, DialogVeiculoClasse, DIALOG_STYLE_LIST, "{ff0000}# {ffffff}Criar veículo", Msg, "Selecionar", "Cancelar");
    return 1;
}
CMD:veh(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Comando de administrador!");
    new Msg[144], Modelo;
    if(sscanf(params, "i", Modelo)) return SendClientMessage(playerid, -1, "{ff0000}Use: /veh [modelo do veículo]");
    if(Modelo <= 400 || Modelo > 612) return SendClientMessage(playerid, -1, "{ff0000}O id não deve ser menor de que 400 nem maior que 612.");
    new Float:p[4], vid; GetPlayerPos(playerid, p[0], p[1], p[2]);
    GetPlayerFacingAngle(playerid, p[3]);
    vid = CreateVehicle(Modelo, p[0] + 1.1, p[1] + 1.1, p[2] + 0.5, p[3], random(255), random(255), 120);
    if(vid == INVALID_VEHICLE_ID) return SendClientMessage(playerid, -1, "{ff0000}Máximo de veículos atingido!");
    LinkVehicleToInterior(vid, GetPlayerInterior(playerid));
    SetVehicleVirtualWorld(vid, GetPlayerVirtualWorld(playerid));
//    PutPlayerInVehicle(playerid, vid, 0);
    format(Msg, 144, "{ffff00}* [Admin] %s criou um veículo id %i", PlayerInfo[playerid][pNome], Modelo);
    SendClientMessageToAll(-1, Msg);
    return 1;
}
CMD:forcarcmd(playerid, params[]) {
	if(PlayerInfo[playerid][pLevel] < 5) return 0;
	new Msg[144], id, cmd[32], pr[32], str[50];
	if(sscanf(params, "us[32]s[32]", id, cmd, pr)) return SendClientMessage(playerid, -1, "{ff0000}Use: /forcarcmd [id] [comando] [parametros após cmd]");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado.");
	if(cmd[0] == '/')
	    strdel(cmd, 0, 1);
	format(str, sizeof(str), "cmd_%s", cmd);
	CallLocalFunction(str, "ds", id, pr);
	format(Msg, 144, "{ffff00}Você fez %s usar o cmd %s", PlayerInfo[id][pNome], cmd);
	SendClientMessage(playerid, -1, Msg);
	format(Msg, 144, "{ff0000}%s fez você usar o comando %s", PlayerInfo[playerid][pNome], cmd);
	SendClientMessage(id, -1, Msg);
	return 1;
}
CMD:levar(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Comando de administrador!");
    new Msg[144], Player1, Player2;
    if(sscanf(params, "uu", Player1, Player2)) return SendClientMessage(playerid, -1, "{ff0000}Use: /levar [id/nome] [até id/nome]");
    if(!IsPlayerConnected(Player1)) return SendClientMessage(playerid, -1, "{ff0000}Jogador 1 desconectado.");
    if(!IsPlayerConnected(Player2)) return SendClientMessage(playerid, -2, "{ff0000}Jogador 2 desconectado.");
    new Float:Pos[3]; GetPlayerPos(Player2, Pos[0], Pos[1], Pos[2]);
    SetPlayerPos(Player1, Pos[0], Pos[1], Pos[2]+1.0);
    format(Msg, sizeof(Msg), "{00FFFF}Você levou %s até %s", PlayerInfo[Player1][pNome], PlayerInfo[Player2][pNome]);
    SendClientMessage(playerid, -1, Msg);
    format(Msg, sizeof(Msg), "{00FFFF}Você foi levado até %s por %s", PlayerInfo[Player2][pNome], PlayerInfo[playerid][pNome]);
    SendClientMessage(Player1, -1, Msg);
    format(Msg, sizeof(Msg), "{00FFFF}%s levou %s até você", PlayerInfo[playerid][pNome], PlayerInfo[Player1][pNome]);
    SendClientMessage(Player2, -1, Msg);
    return 1;
}
CMD:armas(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{8B008B}* O sistema de arenas do servidor não permite que você pegue armas.");
    ShowModelSelectionMenu(playerid, ARMA_LISTA, "Armas");
    return 1;
}
CMD:pagar(playerid, params[]) {
    new Msg[144], Valor, Player;
    if(sscanf(params, "ui", Player, Valor)) return SendClientMessage(playerid, -1, "{ff0000}Use: /pagar [id/nome] [valor]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(PlayerInfo[Player][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Jogador não logado!");
    if(Valor > PlayerInfo[playerid][pDinheiro]) return SendClientMessage(playerid, -1, "{ff0000}Você não tem essa quantia!");
    if(Valor <= 0) return SendClientMessage(playerid, -1, "{ff0000}Apenas valores acima de 0!");
    if(Player == playerid) return SendClientMessage(playerid, -1, "{ff0000}Você não pode pagar para si mesmo!");
    GivePlayerMoney(Player, Valor);
    GivePlayerMoney(playerid, (-Valor));
    format(Msg, sizeof(Msg), "{a9c4e4}Você pagou {00ff00}R${ffffff}%i {a9c4e4}para {ffffff}%s{a9c4e4}.", Valor, PlayerInfo[Player][pNome]);
    SendClientMessage(playerid, -1, Msg);
    format(Msg, sizeof(Msg), "{a9c4e4}Você recebeu {00ff00}R${ffffff}%i {a9c4e4}de {ffffff}%s{a9c4e4}.", Valor, PlayerInfo[playerid][pNome]);
    SendClientMessage(Player, -1, Msg);
    SalvarConta(playerid);
    SalvarConta(Player);
    return 1;
}
CMD:daradmin(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, -1, "{ff0000}Você não tem permissão para isto!");
    new Player, Level, Msg[144];
    if(sscanf(params, "ui", Player, Level)) return SendClientMessage(playerid, -1, "{ff0000}Use: /daradmin [id/nome] [level]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(PlayerInfo[playerid][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Espere o jogador loga-se!");
    if(Level >= sizeof(CargosAdmin) || Level < 0) return SendClientMessage(playerid, -1, "{ff0000}Level inválido.");
    PlayerInfo[Player][pLevel] = Level;
    format(Msg, sizeof(Msg), "{ffff00}%s %s level %i (%s) para %s", PlayerInfo[playerid][pNome], (Level > 0) ? ("deu admin") : ("setou o"), Level, CargosAdmin[Level], PlayerInfo[Player][pNome]);
    SendClientMessageToAll(-1, Msg);
    SalvarConta(Player);
    return 1;
}
CMD:setscore(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 4) return SendClientMessage(playerid, -1, "{ff0000}Você não tem permissão para isto!");
    new Player, Scores, Msg[144];
    if(sscanf(params, "ui", Player, Scores)) return SendClientMessage(playerid, -1, "{ff0000}Use: /setscore [id/nome] [scores]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(PlayerInfo[Player][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Espere o jogador loga-se!");
    PlayerInfo[Player][pScore] = Scores;
    format(Msg, sizeof(Msg), "{ffff00}%s setou o score de %s para %i", PlayerInfo[playerid][pNome], PlayerInfo[Player][pNome], Scores);
    SendClientMessageToAll(-1, Msg);
    SalvarConta(Player);
    return 1;
}
CMD:setgold(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 4) return SendClientMessage(playerid, -1, "{ff0000}Você não tem permissão para isto!");
    new Player, Golds, Msg[144];
    if(sscanf(params, "ui", Player, Golds)) return SendClientMessage(playerid, -1, "{ff0000}Use: /setgold [id/nome] [golds]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(PlayerInfo[Player][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Espere o jogador logar-se!");
    PlayerInfo[Player][pGold] = Golds;
    format(Msg, sizeof(Msg), "{ffff00}%s setou os golds de %s para %i", PlayerInfo[playerid][pNome], PlayerInfo[Player][pNome], Golds);
    SendClientMessageToAll(-1, Msg);
    SalvarConta(Player);
    return 1;
}
CMD:teclas(playerid, params[]) {
    return ShowPlayerDialog(playerid, DialogSemResposta, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Teclas Especiais",
    "Y = Virar/Parar\nH = Pulo\nN = Turbo\n\nAs teclas acima ditas são funcionais em veículos.\nPara ativa-las, use /teclasveiculo.", "Ok", "");
}
CMD:setinfos(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 4) return SendClientMessage(playerid, -1, "{ff0000}Você não tem level para isto!");
    new Player, Mortes, Matou, Msg[144];
    if(sscanf(params, "uii", Player, Mortes, Matou)) return SendClientMessage(playerid, -1, "{ff0000}Use: /setinfos [id/nome] [mortes] [matou]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(PlayerInfo[Player][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Espere o jogador loga-se!");
    PlayerInfo[Player][pMatou] = Matou;
    PlayerInfo[Player][pMorreu] = Mortes;
    format(Msg, sizeof(Msg), "{ffff00}%s setou informações de %s (Matou: %i, Morreu: %i)", PlayerInfo[playerid][pNome], PlayerInfo[Player][pNome], Matou, Mortes);
    SendClientMessageToAll(-1, Msg);
    SalvarConta(Player);
    return 1;
}
CMD:criardinheiro(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid, -1, "{ff0000}Level insuficiente!");
    new Dinheiro, Msg[144];
    if(sscanf(params, "i", Dinheiro)) return SendClientMessage(playerid, -1, "{ff0000}/criardinheiro [quantidade]");
    GivePlayerMoney(playerid,Dinheiro);
    format(Msg, 144, "{ffff00}Você criou {00ff00}R${ffff00}%i", Dinheiro);
    SendClientMessage(playerid, -1, Msg);
    SalvarConta(playerid);
    return 1;
}
CMD:colete(playerid, params[]) {
    if(PlayerInfo[playerid][pDinheiro] < 200) return SendClientMessage(playerid, -1, "{ff0000}Você não tem dinheiro suficiente para comprar o colete!");
    if(GetPVarInt(playerid, "cmd_colete") > gettime()) return SendClientMessage(playerid, -1, "{ff0000}Aguarde uns segundos para usar o /colete novamente.");
    SetPlayerArmour(playerid, 100.0);
    GivePlayerMoney(playerid, (-200));
    SalvarConta(playerid);
    GameTextForPlayer(playerid, "~w~com colete~n~~g~R$~w~200", 5000, 4);
    SetPVarInt(playerid, "cmd_colete", gettime() + 60);
    return 1;
}
CMD:vida(playerid, params[]) {
    if(PlayerInfo[playerid][pDinheiro] < 200) return SendClientMessage(playerid, -1, "{ff0000}Você não tem dinheiro suficiente para se curar!");
    if(GetPVarInt(playerid, "cmd_vida") > gettime()) return SendClientMessage(playerid, -1, "{ff0000}Aguarde uns segundos para usar o /vida novamente.");
    SetPlayerHealth(playerid, 100.0);
    GivePlayerMoney(playerid, (-200));
    SalvarConta(playerid);
    GameTextForPlayer(playerid, "~w~vida recuperada~n~~g~R$~w~200", 5000, 4);
    SetPVarInt(playerid, "cmd_vida", gettime() + 60);
    return 1;
}
CMD:admins(playerid, params[]) {
    new Lista[2000], Adms =0;
    for(new i; i <= GetMaxPlayers(); i++) {
        if(!IsPlayerConnected(i)) continue;
        if(IsPlayerNPC(i)) continue;
        if(PlayerInfo[i][pLevel] <= 0) continue;
        format(Lista, sizeof(Lista), "%s- %s (id: %i) level %i (Cargo: %s)\n", Lista, PlayerInfo[i][pNome], i, PlayerInfo[i][pLevel], CargosAdmin[PlayerInfo[i][pLevel]]);
        Adms++;
    }
    if(Adms == 0) return SendClientMessage(playerid, -1, "{ff0000}Não há administradores online!!");
    format(Lista, sizeof(Lista), "{ff0000}# {ffffff}Administradores online: %i\n\n%s", Adms, Lista);
    ShowPlayerDialog(playerid, DialogSemResposta, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Administradores", Lista, "Ok", "");
    return 1;
}
CMD:ir(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Level insuficiente!");
    new Msg[144], Player;
    if(sscanf(params, "u", Player)) return SendClientMessage(playerid, -1, "{ff0000}Use: /ir [id/nome]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(PlayerInfo[Player][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Jogador ainda não logado!");
    new Float:pos[4];
	if(GetPlayerVehicleID(Player) == 0) {
		GetPlayerPos(Player, pos[0], pos[1], pos[2]);
		GetPlayerFacingAngle(Player, pos[3]);
	}
	else {
		GetVehiclePos(GetPlayerVehicleID(Player), pos[0], pos[1], pos[2]);
		GetVehicleZAngle(GetPlayerVehicleID(Player), pos[3]);
	}
	if(GetPlayerVehicleSeat(playerid) == 0) {
		SetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]+2.0);
		SetVehicleZAngle(GetPlayerVehicleID(playerid), pos[3]);
		SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), GetPlayerVirtualWorld(Player));
		LinkVehicleToInterior(GetPlayerVehicleID(playerid), GetPlayerInterior(Player));
	}
	else {
		SetPlayerPos(playerid, pos[0], pos[1]+0.5, pos[2]+1.0);
		SetPlayerFacingAngle(playerid, pos[3]);
	}
    SetPlayerInterior(playerid, GetPlayerInterior(Player));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(Player));
    format(Msg, sizeof(Msg), "{ffff00}Você foi até o jogador %s", PlayerInfo[Player][pNome]);
    SendClientMessage(playerid, -1, Msg);
    return 1;
}
CMD:trazer(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Level insuficiente!");
    new Msg[144], Player;
    if(sscanf(params, "u", Player)) return SendClientMessage(playerid, -1, "{ff0000}Use: /trazer [id/nome]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(PlayerInfo[Player][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Jogador ainda não logado!");
    new Float:pos[4];
	if(GetPlayerVehicleID(playerid) != 0) {
	    GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), pos[3]);
	}
	else {
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		GetPlayerFacingAngle(playerid, pos[3]);
	}
	if(GetPlayerVehicleSeat(Player) == 0) {
		SetVehiclePos(GetPlayerVehicleID(Player), pos[0], pos[1], pos[2]+2.0);
		SetVehicleZAngle(GetPlayerVehicleID(Player), pos[3]);
		LinkVehicleToInterior(GetPlayerVehicleID(Player), GetPlayerInterior(playerid));
		SetVehicleVirtualWorld(GetPlayerVehicleID(Player), GetPlayerVirtualWorld(playerid));
	}
	else {
	    SetPlayerPos(Player, pos[0], pos[1]+0.5, pos[2]+1.0);
		SetPlayerFacingAngle(Player, pos[3]);
	}
	SetPlayerInterior(Player, GetPlayerInterior(playerid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid));
    format(Msg, 144, "{ffff00}Você trouxe %s", PlayerInfo[Player][pNome]);
    SendClientMessage(playerid, -1, Msg);
    return 1;
}
CMD:a(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Apenas administradores podem usar o comando!");
    new Msg[144], Mensagem[128];
    if(sscanf(params, "s[128]", Mensagem)) return SendClientMessage(playerid, -1, "{ff0000}Use: /a [texto]");
    format(Msg, sizeof(Msg), "{DAA520}ADMIN-CHAT | %s: %s", PlayerInfo[playerid][pNome], Mensagem);
    for(new i = 0; i <= GetMaxPlayers(); i++) {
        if(PlayerInfo[i][pLevel] > 0)
            SendClientMessage(i, -1, Msg);
    }
    return 1;
}
CMD:mudarnick(playerid, params[]) {
    new NovoNome[24], Msg[144];
    if(PlayerInfo[playerid][pDinheiro] < 0) return SendClientMessage(playerid, -1, "{ff0000}Para mudar de nick é necessário R$1000");
    if(sscanf(params, "s[20]", NovoNome)) return SendClientMessage(playerid, -1, "{ff0000}Use: /mudarnick [novo nick]");
    new Query[256], Cache:MudarNick;
    mysql_format(mysql, Query, sizeof(Query), "SELECT Nome FROM usuarios WHERE Nome='%e'", NovoNome);
    MudarNick = mysql_query(mysql, Query, true);
    if(cache_num_rows(mysql)) return SendClientMessage(playerid, -1, "{ff0000}Alguém já usa este nick!"), cache_delete(MudarNick, mysql);
    cache_delete(MudarNick, mysql);
    if(SetPlayerName(playerid, NovoNome) != 1) return SendClientMessage(playerid, -1, "{ff0000}Este nome está em uso ou é inválido!");
    SetPlayerName(playerid, NovoNome);
    format(Msg, sizeof(Msg), "{ffff00}[Mudar Nick] %s mudou para %s", PlayerInfo[playerid][pNome], NovoNome);
    SendClientMessageToAll(-1, Msg);
    GivePlayerMoney(playerid, (-1000));
    format(PlayerInfo[playerid][pNome], 24, NovoNome);
    SalvarConta(playerid);
    return 1;
}
CMD:delveh(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar este comando!");
    new vid, Msg[144];
    if(sscanf(params, "i", vid)) return SendClientMessage(playerid, -1, "{ff0000}Use: /delveh [veiculo id]");
    DestroyVehicle(vid);
    for(new i; i <= GetMaxPlayers(); i++) {
        if(PlayerInfo[i][pVeh] == vid)
            PlayerInfo[i][pVeh] = 0;
    }
    format(Msg, 144, "{ffff00}Veículo %i deletado.", vid);
    SendClientMessage(playerid, -1, Msg);
    return 1;
}
CMD:rv(playerid, params[]) {
	if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, -1, "{ff0000}Level insuficiente!");
	new Msg[144];
	for(new i; i < MAX_VEHICLES; i++) {
		if(IsVehicleInUse(i)) continue;
		SetVehicleToRespawn(i);
	}
	format(Msg, 144, "{ffff00}* %s resetou os veículos", PlayerInfo[playerid][pNome]);
	SendClientMessageToAll(-1, Msg);
	return 1;
}
CMD:mp(playerid, params[]) {
    new Msg[144], Player, Mensagem[128];
    if(sscanf(params, "us[128]", Player, Mensagem)) return SendClientMessage(playerid, -1, "{ff0000}Use: /mp [id/nome] [mensagem]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado.");
    format(Msg, 144, "{00CD00}[MP RECEBIDO] %s [id: %i]: %s", PlayerInfo[playerid][pNome], playerid, Mensagem);
    SendClientMessage(Player, -1, Msg);
    format(Msg, 144, "{9FB6CD}[MP ENVIADO] %s [id: %i]: %s", PlayerInfo[Player][pNome], Player, Mensagem);
    SendClientMessage(playerid, -1, Msg);
    return 1;
}
CMD:pm(playerid, params[]) return cmd_mp(playerid, params);

CMD:vehpara(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Você não tem level para isto.");
    new Player, Modelo, Msg[144];
    if(sscanf(params, "ui", Player, Modelo)) return SendClientMessage(playerid, -1, "{ff0000}Use: /vehpara [id/nome] [modelo id]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(Modelo < 400 || Modelo >= 612) return SendClientMessage(playerid, -1, "{ff0000}Modelo inválido!");
    new Float:Pos[4], vid;
    if(GetPlayerVehicleID(Player) == 0) {
        GetPlayerPos(Player, Pos[0], Pos[1], Pos[2]);
        GetPlayerFacingAngle(Player, Pos[3]);
    }
    else {
        GetVehiclePos(GetPlayerVehicleID(Player), Pos[0], Pos[1], Pos[2]);
        GetPlayerFacingAngle(GetPlayerVehicleID(Player), Pos[3]);
    }
	new Cores[2];
	Cores[0] = random(255);
	Cores[1] = random(255);
    vid = CreateVehicle(Modelo, Pos[0], Pos[1], Pos[2], Pos[3], Cores[0], Cores[1], 120);
    if(vid == INVALID_VEHICLE_ID) return SendClientMessage(playerid, -1, "{ff0000}Máximo de veículos atingido.");
    if(PlayerInfo[Player][pVeh] != 0 && vid != PlayerInfo[Player][pVeh])
        DestroyVehicle(PlayerInfo[Player][pVeh]);
    PlayerInfo[Player][pVeh] = vid;
	PlayerInfo[Player][VehModelo] = Modelo;
	for(new i; i < 2; i++)
	    PlayerInfo[Player][VehCores][i] = Cores[i];
	for(new i; i < 14; i++)
	    PlayerInfo[Player][VehComponentes][i] = 0;
    PutPlayerInVehicle(Player, vid, 0);
    format(Msg, 144, "{FFB90F}*** %s criou um %s para %s", PlayerInfo[playerid][pNome], NomesVeiculos[Modelo-400], PlayerInfo[Player][pNome]);
    SendClientMessageToAll(-1, Msg);
    SalvarConta(Player);
    return 1;
}
CMD:tapa(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar este comando!");
    new Player, Msg[144];
    if(sscanf(params, "u", Player)) return SendClientMessage(playerid, -1, "{ff0000}Use: /tapa [id/nome]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(PlayerInfo[Player][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Jogador ainda não logado!");
    new Float:pos[3]; GetPlayerPos(Player, pos[0], pos[1], pos[2]);
    SetPlayerPos(Player, pos[0], pos[1], pos[2] + 25.0);
    format(Msg, 144, "{ff0000}* %s deu um tapa em %s", PlayerInfo[playerid][pNome], PlayerInfo[Player][pNome]);
    SendClientMessageToAll(-1, Msg);
    return 1;
}
CMD:irpara(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Comando apenas para admins!");
    new Float:pos[3];
    if(sscanf(params, "p<,>fff", pos[0], pos[1], pos[2])) return SendClientMessage(playerid, -1, "{ff0000}Use: /irpara [x] [y] [z]");
    if(GetPlayerVehicleSeat(playerid) == 0)
        SetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
    else
        SetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    return 1;
}
CMD:kick(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar este comando!");
    new Player, Motivo[128], Msg[144];
    if(sscanf(params, "us[128]", Player, Motivo)) return SendClientMessage(playerid, -1, "{ff0000}Use: /kick [id/nome] [motivo]");
    if(!IsPlayerConnected(playerid)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    format(Msg, 144, "{00CED1}* %s kickou %s, motivo: %s", PlayerInfo[playerid][pNome], PlayerInfo[Player][pNome], Motivo);
    SendClientMessageToAll(-1, Msg);
    format(Msg, 144, "{00CED1}* Você foi kickado por %s, pelo motivo: %s", PlayerInfo[playerid][pNome], Motivo);
    KickMsg(Player, Msg);
    return 1;
}
CMD:banip(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar este comando!");
    new Player, Motivo[128], Msg[144], IP[16];
    if(sscanf(params, "us[128]", Player, Motivo)) return SendClientMessage(playerid, -1, "{ff0000}Use: /banip [id/nome] [motivo]");
    if(!IsPlayerConnected(playerid)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    format(Msg, 144, "{4682B4}* %s baniu o ip de %s, motivo: %s", PlayerInfo[playerid][pNome], PlayerInfo[Player][pNome], Motivo);
    SendClientMessageToAll(-1, Msg);
    GetPlayerIp(Player, IP, sizeof(IP));
    format(Msg, 144, "{4682B4}* %s (ip: %s) banido.", PlayerInfo[Player][pNome], IP);
    SendClientMessage(playerid, -1, Msg);
    BanEx(Player, Motivo);
    return 1;
}
CMD:cmds(playerid, params[]) {
    ShowPlayerDialog(playerid, DialogComandosClasse, DIALOG_STYLE_LIST, "{ff0000}# {ffffff}Comandos", "Comandos básicos\r\nComandos Gerais\r\nComandos de veículo\r\nComandos de admin\r\n", "Selecionar", "Cancelar");
    DeletePVar(playerid, "cmd_lista");
    DeletePVar(playerid, "cmd_classe");
    return 1;
}
CMD:banserial(playerid, fuck[])
{
    new Otario, Motivo[128], Msg[144], Nome[24], Admin[25], SerialTempoBan;
    if(PlayerInfo[playerid][pLevel] < 4) return 0;
    if(sscanf(fuck, "uis[128]", Otario, SerialTempoBan, Motivo)) return SendClientMessage(playerid, 0xffffffff, "{ff0000}Use: /banserial [id/nome] [tempo que o serial ficara ban (dias)] [Motivo]");
    if(!IsPlayerConnected(Otario)) return SendClientMessage(playerid, -1, "{ff0000}Jogador off!");
    GetPlayerName(playerid, Admin, 25);
    GetPlayerName(Otario, Nome, 24);
    format(Msg, 144, "{ffffff}%s {a9c4e4}foi banido permanentemente por {ffffff}%s{a9c4e4}.", Nome, Admin);
    SendClientMessageToAll(0xffffffff, Msg);
    format(Msg, 144, "{ff0000}Você foi banido por {ffffff}%s{ff0000}.", Admin);
    SendClientMessage(Otario, 0xffffffff, Msg);
    format(Msg, 144, "{ff0000}Motivo: {ffffff}%s{ff0000}.", Motivo);
    SendClientMessage(Otario, 0xffffffff, Msg);
    SendClientMessage(Otario, 0xffffffff, "{ff0000}Você está banido permanentemente!");
    SendClientMessage(playerid, 0xffffffff, "{a9c4e4}O jogador foi banido por serial e somente será desbanido em caso de engano.");
	new Serial[128], Query[360], DataBan[50], BanIP[16], gpciBanTempo = gettime() + (60*60*24*SerialTempoBan);
	gpci(Otario, Serial, sizeof(Serial));
    new Data[3];
    getdate(Data[2], Data[1], Data[0]);
	format(DataBan, sizeof(DataBan), "%02d/%02d/%d", Data[0], Data[1], Data[2]);
	GetPlayerIp(Otario, BanIP, sizeof(BanIP));
	mysql_format(mysql, Query, sizeof(Query), "INSERT INTO gpci (Nome,IP,Serial,Data,Motivo,DesbanAuto) VALUES ('%s', '%s', '%s', '%s', '%e', %i)",Nome, BanIP, Serial, DataBan, Motivo, gpciBanTempo);
	mysql_query(mysql, Query, false);
	strcat(Motivo, "(SERIAL)");
	BanEx(Otario, Motivo);
    return 1;
}
CMD:desbanirserial(playerid, params[])
{
    if(PlayerInfo[playerid][pLevel] < 4) return 0;
    new SerialID, Info[400];
    if(sscanf(params, "i", SerialID)) return SendClientMessage(playerid, -1, "{ff0000}Use: /desbanirserial [id do banimento por serial]");
    new Cache:GPCI, Query[200];
	mysql_format(mysql, Query, sizeof(Query), "SELECT * FROM gpci WHERE ID=%i", SerialID);
	GPCI = mysql_query(mysql, Query, true);
	if(cache_num_rows(mysql) > 0) {
		new Serial[128], Nome[24], xData[24], Motivo[128], Ip[16];
		cache_get_field_content(0, "Serial", Serial, mysql, 128);
		cache_get_field_content(0, "Nome", Nome, mysql, 24);
		cache_get_field_content(0, "Data", xData, mysql, 50);
		cache_get_field_content(0, "Motivo", Motivo, mysql, 128);
		cache_get_field_content(0, "IP", Ip, mysql, 16);
		format(Info, sizeof(Info), "Informações de serial banido id %i\n\nSerial: %s\nData: %s\nNome do jogador: %s\nIP: %s\nMotivo do banimento: %s\n\nEste serial foi deletado.", SerialID, Serial, xData, Nome, Ip, Motivo);
		ShowPlayerDialog(playerid, DialogSemResposta, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Banimento por Serial", Info, "Ok", "");
		mysql_format(mysql, Query, sizeof(Query), "DELETE FROM gpci WHERE ID=%i", SerialID);
		mysql_query(mysql, Query, false);
		format(Query, sizeof(Query), "unbanip %s", Ip);
		SendRconCommand(Query);
		SendRconCommand("reloadbans");
	}
	else SendClientMessage(playerid, -1, "{ff0000}Nenhum serial banido encontrado!");
	cache_delete(GPCI, mysql);
	return 1;
}
CMD:desbanserial(playerid, params[]) return cmd_desbanirserial(playerid, params);
CMD:seriaisbans(playerid, params[]) {
	if(PlayerInfo[playerid][pLevel] < 1) return 0;
	new Cache:Seriais = mysql_query(mysql, "SELECT ID,Nome,Serial FROM gpci ORDER BY ID DESC LIMIT 100", true);
	if(cache_num_rows(mysql) > 0) {
	    new Dialog[2000];
	    for(new i; i < cache_num_rows(mysql); i++) {
			new ID = cache_get_field_content_int(i, "ID", mysql), Nome[24], Serial[128];
			cache_get_field_content(i, "Nome", Nome, mysql, sizeof(Nome));
			cache_get_field_content(i, "Serial", Serial, mysql, sizeof(Serial));
			format(Dialog,sizeof(Dialog), "ID:%i - Nome: %s - Serial: %s", ID,Nome,Serial);
			strcat(Dialog, "\r\n");
		}
		ShowPlayerDialog(playerid, DialogBansSeriais, DIALOG_STYLE_LIST, "{ff0000}# {ffffff}Seriais banidos", Dialog, "Selecionar", "Cancelar");
	}
	else
	    SendClientMessage(playerid, -1, "{ff0000}Nenhum banimento..");
	cache_delete(Seriais, mysql);
	return 1;
}
CMD:ignorarserial(playerid, params[])
{
	if(PlayerInfo[playerid][pLevel] < 5) return 0;
	new SerialID, Nome[24];
	if(sscanf(params, "is[24]", SerialID, Nome)) return SendClientMessage(playerid, -1, "{ff0000}Use: /ignorarserial [id do ban serial] [usuário]");
	new Cache:CheckConta, string[300];
	mysql_format(mysql, string, sizeof(string), "SELECT id FROM usuarios WHERE Nome='%e' LIMIT 1", Nome);
	CheckConta = mysql_query(mysql, string, true);
	if(cache_num_rows(mysql) > 0)
	{
		new Cache:CheckSerial, ID_Player = cache_get_field_content_int(0, "ID", mysql);
		mysql_format(mysql, string, sizeof(string), "SELECT Ignorar FROM gpci WHERE ID=%i", SerialID);
		CheckSerial = mysql_query(mysql, string, true);
		if(cache_num_rows(mysql) > 0) {
			new Ignorar[100], Ignore_List[200], bool:AdicionarLista = true;
			cache_get_field_content(0, "Ignorar", Ignore_List, mysql);
			unformat(Ignore_List, "p<,>a<i>[100]", Ignorar);
			for(new i; i < 100; i++) {
				if(Ignorar[i] == ID_Player && Ignorar[i] != 0) {
					Ignorar[i] = 0;
					AdicionarLista = false;
					break;
				}
				if(Ignorar[i] == 0 && AdicionarLista == true) {
					Ignorar[i] = ID_Player;
					break;
				}
			}
			new Msg[144], st[200];
			for(new i; i < 100; i++) {
				if(Ignorar[i] == 0) continue;
				format(st, sizeof(st), "%s%i,", st, Ignorar[i]);
			}
			mysql_format(mysql, string, sizeof(string), "UPDATE gpci SET Ignorar='%s' WHERE ID=%i", st, SerialID);
			mysql_query(mysql, string, false);
			if(AdicionarLista == true)
				format(Msg, 144, "{ffff00}Adicionado a lista de ban ignorado do banimento por serial id %i a conta %s!", SerialID, Nome);
			else
			    format(Msg, 144, "{ffff00}Removida a conta %s da lista de ban ignorado do banimento por serial id %i!", Nome, SerialID);
			SendClientMessage(playerid, -1, Msg);
		}
		else
		    SendClientMessage(playerid, -1, "{ff0000}Banimento por serial não encontrado!");
		cache_delete(CheckSerial, mysql);
	}
	else
	    SendClientMessage(playerid, -1, "{ff0000}Nenhuma conta encontrada!");
	cache_delete(CheckConta, mysql);
	return 1;
}
CMD:ann(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Este anuncio é de admin, você não tem permissão!");
    new Msg[144], Mensagem[128];
    if(sscanf(params, "s[128]", Mensagem)) return SendClientMessage(playerid, -1, "{ff0000}Use: /ann [anuncio]");
    format(Msg, 144, "{00ff00}* [ADMIN] %s: %s", PlayerInfo[playerid][pNome], Mensagem);
    SendClientMessageToAll(-1, Msg);
    return 1;
}
CMD:cnn(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, -1, "{ff0000}Este comando não está liberado para você.");
    new Msg[256], Mensagem[144];
    if(sscanf(params, "s[144]", Mensagem)) return SendClientMessage(playerid, -1, "{ff0000}Use: /cnn [texto]");
    format(Msg, sizeof(Msg), "~g~%s: ~w~%s", PlayerInfo[playerid][pNome], Mensagem);
    TextDrawSetString(DrawAnuncio, Msg);
    SetTimer("LimparAnuncio", 10000, false);
    return 1;
}

CMD:eu(playerid, params[]) {
    if(GetPVarInt(playerid, "tempo_anuncio") > gettime()) return SendClientMessage(playerid, -1, "{ff0000}Espere uns segundos para usar novamente!");
    new Msg[144], Mensagem[128];
    if(sscanf(params, "s[128]", Mensagem)) return SendClientMessage(playerid, -1, "{ff0000}Use: /eu [texto]");
    format(Msg, 144, "{B452CD}* %s: %s", PlayerInfo[playerid][pNome], Mensagem);
    SendClientMessageToAll(-1, Msg);
    SetPVarInt(playerid, "tempo_anuncio", gettime() + 30);
    return 1;
}
CMD:dia(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar este comando!");
    SetWorldTime(12);
    new Msg[144]; format(Msg, sizeof(Msg), "{ffff00}- %s deixou o servidor de dia", PlayerInfo[playerid][pNome]);
    SendClientMessageToAll(-1, Msg);
    return 1;
}

CMD:tarde(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar este comando!");
    SetWorldTime(19);
    new Msg[144]; format(Msg, sizeof(Msg), "{ffff00}- %s deixou o servidor de tarde", PlayerInfo[playerid][pNome]);
    SendClientMessageToAll(-1, Msg);
    return 1;
}
CMD:noite(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar este comando!");
    SetWorldTime(0);
    new Msg[144]; format(Msg, sizeof(Msg), "{ffff00}- %s deixou o servidor de noite", PlayerInfo[playerid][pNome]);
    SendClientMessageToAll(-1, Msg);
    return 1;
}
CMD:arenas(playerid, params[]) {
    new Dialog[2000];
    for(new i; i < sizeof(ArenasDM); i++) {
        format(Dialog, sizeof(Dialog), "%s%s\r\n", Dialog, ArenasDM[i][ArenaNome]);
    }
    ShowPlayerDialog(playerid, DialogArenasDM, DIALOG_STYLE_LIST, "{ff0000}# {ffffff}Arenas", Dialog, "Selecionar", "Cancelar");
    return 1;
}
CMD:sairarena(playerid, params[]) {
    if(PlayerInfo[playerid][EmArena] == false) return SendClientMessage(playerid, -1, "{ff0000}Você não está em uma arena.");
	new Msg[144];
	format(Msg, 144, "{EEAD0E}* %s saiu da arena.", PlayerInfo[playerid][pNome]);
	for(new i; i <= GetMaxPlayers(); i++)
	    if(IsPlayerConnected(i) && PlayerInfo[i][ArenaID] == PlayerInfo[playerid][ArenaID] && PlayerInfo[i][EmArena] == true)
	        SendClientMessage(i, -1, Msg);
	ResetPlayerWeapons(playerid);
    PlayerInfo[playerid][EmArena] = false;
    PlayerInfo[playerid][ArenaID] = 0;
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SpawnPlayer(playerid);
    SendClientMessage(playerid, -1, "{7A378B}Você saiu da arena!");
    return 1;
}
CMD:afk(playerid, params[]) {
    if(PlayerInfo[playerid][AFK] == true) return SendClientMessage(playerid, -1, "{ff0000}Você já está AFK!");
    new Msg[144];
    TogglePlayerControllable(playerid, false);
    PlayerInfo[playerid][AFK] = true;
    format(Msg, 144, "{7A378B}* %s está afk.", PlayerInfo[playerid][pNome]);
    SendClientMessageToAll(-1, Msg);
    return 1;
}
CMD:sairafk(playerid, params[]) {
    if(PlayerInfo[playerid][AFK] == false) return SendClientMessage(playerid, -1, "{ff0000}Você não está AFK!");
    new Msg[144];
    TogglePlayerControllable(playerid, true);
    PlayerInfo[playerid][AFK] = false;
    format(Msg, 144, "{EEAD0E}* %s saiu do modo afk.", PlayerInfo[playerid][pNome]);
    SendClientMessageToAll(-1, Msg);
    return 1;
}
CMD:jogadoresafk(playerid, params[]) {
    new Dialog[2000], pafk, Linha;
    for(new i; i <= GetMaxPlayers(); i++) {
        if(!IsPlayerConnected(i)) continue;
        if(IsPlayerNPC(i)) continue;
        if(PlayerInfo[i][AFK] == false) continue;
        format(Dialog, sizeof(Dialog), "%s- %s (id: %i)", Dialog, PlayerInfo[i][pNome], i);
        pafk++;
        Linha++;
        if(Linha >= 4) {
            Linha = 0;
            format(Dialog, sizeof(Dialog), "%s\n", Dialog);
        }
        else
            format(Dialog, sizeof(Dialog), "%s\t", Dialog);
    }
    if(pafk == 0) return SendClientMessage(playerid, -1, "{ff0000}Não há jogadores ausentes.");
    format(Dialog, sizeof(Dialog), "{FF7F50}# {ffffff}Jogadores ausentes: %i\n\n%s", pafk, Dialog);
    ShowPlayerDialog(playerid, DialogSemResposta, DIALOG_STYLE_MSGBOX, "{FF7F50}# {ffffff}Jogadores afk", Dialog, "Fechar", "");
    return 1;
}
CMD:jetpack(playerid, params[]) {
	if(PlayerInfo[playerid][pDinheiro] < 10000) return SendClientMessage(playerid, -1, "{ff0000}Você não tem dinheiro suficiente!");
    GivePlayerMoney(playerid, (-10000));
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    return 1;
}
CMD:setint(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Level insuficiente.");
    new Interior, Player, Msg[144];
    if(sscanf(params, "ui", Player, Interior)) return SendClientMessage(playerid, -1, "{ff0000}Use: /setint [id/nome] [interior]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "Jogador desconectado");
    SetPlayerInterior(Player, Interior);
    format(Msg, 144, "{912CEE}* Você setou o interior de %s para %i", PlayerInfo[Player][pNome], Interior);
    SendClientMessage(playerid, -1, Msg);
    format(Msg, 144, "{912CEE}* %s setou seu interior para %i", PlayerInfo[playerid][pNome], Interior);
    SendClientMessage(Player, -1, Msg);
    return 1;
}
CMD:calar(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar este comando!");
    new Player, Motivo[128];
    if(sscanf(params, "us[128]", Player, Motivo)) return SendClientMessage(playerid, -1, "{ff0000}Use: /calar [id/nome] [motivo]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(PlayerInfo[Player][Mudo] == 1) return SendClientMessage(playerid, -1, "{ff0000}Jogador já está calado!");
    new Msg[144];
    PlayerInfo[Player][Mudo] = 1;
    format(Msg, 144, "{32CD32}* %s calou %s, motivo: %s", PlayerInfo[playerid][pNome], PlayerInfo[Player][pNome], Motivo);
    SendClientMessageToAll(-1, Msg);
    SalvarConta(Player);
    return 1;
}
CMD:descalar(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar este comando!");
    new Player;
    if(sscanf(params, "u", Player)) return SendClientMessage(playerid, -1, "{ff0000}Use: /descalar [id/nome]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Jogador desconectado!");
    if(PlayerInfo[Player][Mudo] == 0) return SendClientMessage(playerid, -1, "{ff0000}Jogador não está mudo!");
    new Msg[144];
    PlayerInfo[Player][Mudo] = 0;
    format(Msg, 144, "{32CD32}* %s descalou %s", PlayerInfo[playerid][pNome], PlayerInfo[Player][pNome]);
    SendClientMessageToAll(-1, Msg);
    SalvarConta(Player);
    return 1;
}
CMD:mudos(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar este comando!");
    new Dialog[2000], Players, Linha;
    for(new i; i <= GetMaxPlayers(); i++) {
        if(!IsPlayerConnected(i)) continue;
        if(IsPlayerNPC(i)) continue;
        if(PlayerInfo[i][Mudo] == 0) continue;
        Players++;
        format(Dialog, sizeof(Dialog), "%s- %s (id: %i)", Dialog, PlayerInfo[i][pNome], i);
        Linha++;
        if(Linha >= 4) {
            format(Dialog, sizeof(Dialog), "%s\n", Dialog);
            Linha=0;
        }
        else
            format(Dialog, sizeof(Dialog), "%s\t", Dialog);
    }
    ShowPlayerDialog(playerid, DialogDescalar, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}Jogadores mudos", Dialog, "Descalar", "Cancelar");
    return 1;
}

CMD:relato(playerid, params[]) {
    new Player, Motivo[128], Msg[144];
    if(sscanf(params, "us[128]", Player, Motivo)) return SendClientMessage(playerid, -1, "{ff0000}Use: /relato [id/nome] [motivo]");
    if(!IsPlayerConnected(Player)) return SendClientMessage(playerid, -1, "{ff0000}Este jogador está desconectado do servidor.");
    if(PlayerInfo[Player][Logado] == false) return SendClientMessage(playerid, -1, "{ff0000}Este jogador está conectado mas não logado, aguarde o mesmo logar-se.");
    if(PlayerInfo[Player][pRelatoTempo] > gettime()) return SendClientMessage(playerid, -1, "{8A2BE2}Este jogador já foi relatado recentemente.");
    PlayerInfo[Player][pRelatoTempo] = gettime() + 30;
    format(Msg, 144, "{6495ED}Você relatou {ffffff}%s{6495ED} para administração do servidor.", PlayerInfo[Player][pNome]);
    SendClientMessage(playerid, -1, Msg);
    format(Msg, 144, "{43CD80}** %s relatou %s, motivo: %s", PlayerInfo[playerid][pNome], PlayerInfo[Player][pNome], Motivo);
    for(new i; i <= GetMaxPlayers(); i++) {
        if(!IsPlayerConnected(i)) continue;
        if(PlayerInfo[i][pLevel] <= 0) continue;
        SendClientMessage(i, -1, Msg);
    }
    return 1;
}
CMD:limparchat(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 1) return SendClientMessage(playerid, -1, "{ff0000}Você não tem permissão para isto.");
    for(new i; i < 100; i++)
        SendClientMessageToAll(-1, " ");
    return 1;
}
CMD:lc(playerid, params[]) return cmd_limparchat(playerid, params);

CMD:contagem(playerid, params[]) {
    if(PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, -1, "{ff0000}Você não pode usar o comando.");
    new cx, MsgFinal[128];
    if(Contagem[ContagemSegundos] != 0) return SendClientMessage(playerid, -1, "{ff0000}Há uma contagem em execução no momento.");
    if(sscanf(params, "is[128]", cx, MsgFinal)) return SendClientMessage(playerid, -1, "{ff0000}Use: /contagem [segundos] [mensagem final]");
    Contagem[ContagemSegundos] = cx;
    format(Contagem[TextoContagem], 128, MsgFinal);
    SetTimer("Contando", 1000, false);
    return 1;
}

CMD:contar(playerid, params[])
{
	if(Count == 0)
	{
	    new cstring[128]; Count = 4;
	    format(cstring, sizeof(cstring), "{6495ED}%s iniciou uma contagem!", PlayerInfo[playerid][pNome]);
	    SendClientMessageToAll(-1, cstring);
		SetTimerEx("CountD", 1000, false, "i", playerid);
	}
	//--------------------------------------------------------------------------
	else return
	SendClientMessage(playerid, -1,"{6495ED}Já existe uma contagem em andamento!");
	//--------------------------------------------------------------------------
	return 1;
}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
forward CountD(playerid);
public CountD(playerid)
{
	if(Count == 4)
	{
	    Count = 3;
		GameTextForAll("~b~3", 1000, 6);
        for(new i; i <= GetMaxPlayers(); i++) {
    	PlayerPlaySound(i, 1056,0,0,0);}
		SetTimerEx("CountD", 1000, false, "i", playerid);
	}
	else if(Count == 3)
	{
	    Count = 2;
		GameTextForAll("~y~2", 1000, 6);
        for(new i; i <= GetMaxPlayers(); i++) {
    	PlayerPlaySound(i, 1056,0,0,0);}
		SetTimerEx("CountD", 1000, false, "i", playerid);
	}
	else if(Count == 2)
	{
 		Count = 1;
		GameTextForAll("~r~1", 1000, 6);
        for(new i; i <= GetMaxPlayers(); i++) {
    	PlayerPlaySound(i, 1056,0,0,0);}
		SetTimerEx("CountD", 1000, false, "i", playerid);
	}
	else if(Count == 1)
	{
	    Count = 0;
	    GameTextForAll("~b~vai ~y~vai~r~ vai", 2000, 6);
        for(new i; i <= GetMaxPlayers(); i++) {
        PlayerPlaySound(i, 3200,0,0,0);}
	}
}

CMD:radios(playerid, params[])
{
    new Radios[2000];
    for(new i; i < sizeof(WebRadios); i++)
        if(strlen(WebRadios[i][NomeWebRadio]) > 0)
            format(Radios, sizeof(Radios), "%s%s\r\n", Radios,WebRadios[i][NomeWebRadio]);
    format(Radios, sizeof(Radios), "%s{ff0000}Desligar rádio\r\n", Radios);
    ShowPlayerDialog(playerid, DialogRadio, DIALOG_STYLE_LIST, "Web Rádios", Radios, "Escolher", "Cancelar");
    return 1;
}
CMD:surdo(playerid, params[]) return StopAudioStreamForPlayer(playerid);
CMD:s(playerid, params[]) return cmd_surdo(playerid, params);
CMD:animes(playerid, params[]) {
    new Dialog[2000], Linha, Animes;
    for(new i; i < sizeof(AnimesComandos); i++) {
        format(Dialog, sizeof(Dialog), "%s%s - ", Dialog, AnimesComandos[i]);
        Linha++;
        Animes++;
        if(Linha >= 6) {
            format(Dialog, sizeof(Dialog),"%s\n", Dialog);
            Linha=0;
        }
    }
    format(Dialog, sizeof(Dialog), "{ffffff}O servidor tem %i animes disponíveis (para parar uma animação use /pararanim):\n\n%s", Animes, Dialog);
    return ShowPlayerDialog(playerid, DialogSemResposta, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Animes", Dialog, "Ok", "");
}
CMD:mudarsenha(playerid, params[]) 	return ShowPlayerDialog(playerid, DialogMudarSenha, DIALOG_STYLE_PASSWORD, "{00ff00}# {ffffff}Mudar senha", "Digite sua antiga senha:", "Ok", "");

CMD:novidades(playerid, params[]) {
    new Dialog[3000];
    for(new i; i < sizeof(Novidades); i++)
    {
        format(Dialog, sizeof(Dialog), "%s%s\n", Dialog, Novidades[i]);
    }
    return ShowPlayerDialog(playerid, DialogSemResposta, DIALOG_STYLE_MSGBOX, "{ff0000}# {ffffff}Novidades", Dialog, "Ok", "");
}
CMD:meuveh(playerid, params[]) {
	if(PlayerInfo[playerid][EmArena] == true) return SendClientMessage(playerid, -1, "{ff0000}Você não pode criar veiculos dentro de uma arena!");
	if(PlayerInfo[playerid][VehModelo] == 0) return SendClientMessage(playerid, -1, "{ff0000}Você não tem um veículo criado..");
	if(GetPlayerVehicleID(playerid) != 0 && GetPlayerVehicleID(playerid) == PlayerInfo[playerid][pVeh]) return SendClientMessage(playerid, -1, "{ff0000}Você já está dentro de seu veículo!");
	new vid, Float:pos[4], antes = (GetPlayerVehicleSeat(playerid) == 0) ? (GetPlayerVehicleID(playerid)) : (0);
	if(GetPlayerVehicleID(playerid) == 0) {
		GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
		GetPlayerFacingAngle(playerid, pos[3]);
	}
	else {
		GetVehiclePos(GetPlayerVehicleID(playerid), pos[0], pos[1], pos[2]);
		GetVehicleZAngle(GetPlayerVehicleID(playerid), pos[3]);
	}
	vid = PlayerInfo[playerid][pVeh];
	if(vid == 0) {
	    vid = CreateVehicle(PlayerInfo[playerid][VehModelo], pos[0],pos[1], pos[2], pos[3], PlayerInfo[playerid][VehCores][0],PlayerInfo[playerid][VehCores][1], 120);
		if(vid == INVALID_VEHICLE_ID) return SendClientMessage(playerid, -1, "{ff0000}Limite de veículos do servidor atingido!");
        VehInfo[vid][DonoID] = playerid;
        PlayerInfo[playerid][pVeh] = vid;
        if(PlayerInfo[playerid][VehPintura] > 0)
	        ChangeVehiclePaintjob(vid, PlayerInfo[playerid][VehPintura]-1);
		for(new i; i < 14; i++) {
			if(PlayerInfo[playerid][VehComponentes][i] == 0) continue;
			AddVehicleComponent(vid, PlayerInfo[playerid][VehComponentes][i]);
		}
	    if(PlayerInfo[playerid][NeonID] != 0) {
			if(VehInfo[vid][NeonDireito] != 0) {
				DestroyDynamicObject(VehInfo[vid][NeonDireito]);
				DestroyDynamicObject(VehInfo[vid][NeonEsquerdo]);
			}
			new Neon = PlayerInfo[playerid][NeonID];
			VehInfo[vid][NeonDireito] = CreateDynamicObject(Neons[Neon][NeonID],0,0,0,0,0,0);
			VehInfo[vid][NeonEsquerdo] = CreateDynamicObject(Neons[Neon][NeonID],0,0,0,0,0,0);
			AttachDynamicObjectToVehicle(VehInfo[vid][NeonEsquerdo], vid, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
			AttachDynamicObjectToVehicle(VehInfo[vid][NeonDireito], vid, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		}
	}
	else {
		SetVehiclePos(vid, pos[0], pos[1], pos[2]);
		SetVehicleZAngle(vid, pos[3]);
	}
	PutPlayerInVehicle(playerid, vid, 0);
	LinkVehicleToInterior(vid, GetPlayerInterior(playerid));
	SetVehicleVirtualWorld(vid, GetPlayerVirtualWorld(playerid));
   	if(antes != 0)
		SetVehicleToRespawn(antes);
	return 1;
}
CMD:neon(playerid, params[]) {
	new Dialog[500];
	for(new i = 1; i < sizeof(Neons); i++) {
		strcat(Dialog, Neons[i][NeonCor]);
		strcat(Dialog, "\r\n");
	}
	strcat(Dialog, "Remover Neon\r\n");
	ShowPlayerDialog(playerid, DialogPorNeon,DIALOG_STYLE_LIST, "{ff0000}# {ffffff}Neon's", Dialog, "Escolher", "Cancelar");
	return 1;
}
CMD:rodas(playerid, params[]) {
	if(GetPlayerVehicleSeat(playerid) != 0) return SendClientMessage(playerid, -1, "{ff0000}Esteja pilotando um veículo!");
	new Dialog[300];
	for(new i; i < sizeof(Rodas); i++) {
		strcat(Dialog, Rodas[i][RodaNome]);
		strcat(Dialog, "\r\n");
	}
	strcat(Dialog, "{ffff00}Roda padrão");
	ShowPlayerDialog(playerid, DialogRodas, DIALOG_STYLE_LIST, "{ff0000}# {ffffff}Rodas", Dialog, "Selecionar", "Cancelar");
	return 1;
}
CMD:nos(playerid, params[]) {
	if(GetPlayerVehicleSeat(playerid) != 0) return SendClientMessage(playerid, -1, "{ff0000}Esteja pilotando um veículo!");
	return AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
}
CMD:suspensao(playerid, params[]) {
	if(GetPlayerVehicleSeat(playerid) != 0) return SendClientMessage(playerid, -1, "{ff0000}Esteja pilotando um veículo!");
	return AddVehicleComponent(GetPlayerVehicleID(playerid), 1087);
}
CMD:cor(playerid, params[]) {
	if(GetPlayerVehicleSeat(playerid) != 0) return SendClientMessage(playerid, -1, "{ff0000}Esteja pilotando um veículo!");
	new Dialog[4500], Linha, Total;
	for(new i = GetPVarInt(playerid, "Cor_pag"); i < sizeof(CoresVeiculos); i++) {
		if(Total >= 100) {
			strcat(Dialog, "\n\nDigite \"próxima\".");
			break;
		}
		format(Dialog, sizeof(Dialog), "%s{ffffff}%i - {%06x}Cor", Dialog, i, CoresVeiculos[i] >>> 8);
		Linha++;
		Total++;
		if(Linha >= 12) {
			strcat(Dialog, "\n");
			Linha=0;
		}
		else {
			strcat(Dialog, " {ffffff}| ");
		}
	}
	return ShowPlayerDialog(playerid, DialogVehCor, DIALOG_STYLE_INPUT, "{ff0000}# {ffffff}Cor - Use: cor1,cor2", Dialog, "Ok", "Cancelar");
}
CMD:minhacor(playerid, params[]) {
	new cor;
	if(sscanf(params, "x", cor)) return SendClientMessage(playerid, -1,"{ff0000}Use: /minhacor [cor em hexadecimal]");
	SetPlayerColor(playerid, cor);
	new Msg[144];
	format(Msg, 144, "{a9c4e4}A Cor de seu nome agora: {%06x}%s", cor >>> 8, PlayerInfo[playerid][pNome]);
	return SendClientMessage(playerid, -1, Msg);
}
CMD:prevercor(playerid, params[]) {
	new cor, Msg[144];
   	if(sscanf(params, "x", cor)) return SendClientMessage(playerid, -1,"{ff0000}Use: /prevercor [cor em hexadecimal]");
	format(Msg, 144, "{a9c4e4}Prevendo cor: {%06x}%x", cor >>> 8, cor);
	return SendClientMessage(playerid, -1, Msg);
}
CMD:mododrift(playerid, params[]) {
	if(PlayerInfo[playerid][ModoDrift] == 1) {
        PlayerInfo[playerid][ModoDrift] = 0;
        return SendClientMessage(playerid, -1, "{ff0000}Modo drift desabilitado!"), SalvarConta(playerid);
	}
	PlayerInfo[playerid][ModoDrift] = 1;
	return SendClientMessage(playerid, -1, "{ffff00}Modo drift habilitado!"), SalvarConta(playerid);
}
//Animes by Delete
CMD:push(playerid, params[]) return ApplyAnimation(playerid,"GANGS","shake_cara",4.0,0,0,0,0,0);
CMD:cakick(playerid, params[]) return ApplyAnimation(playerid,"POLICE","Door_Kick",4.0,0,0,0,0,0);
CMD:lowbodypush(playerid, params[]) return ApplyAnimation(playerid,"GANGS","shake_carSH",4.0,0,0,0,0,0);
CMD:spray(playerid, params[]) return ApplyAnimation(playerid,"SPRAYCAN","spraycan_full",4.0,0,0,0,0,0);
CMD:headbutt(playerid, params[]) return ApplyAnimation(playerid,"WAYFARER","WF_Fwd",4.0,0,0,0,0,0);
CMD:medic(playerid, params[]) return ApplyAnimation(playerid,"MEDIC","CPR",4.0,0,0,0,0,0);
CMD:koface(playerid, params[]) return ApplyAnimation(playerid,"PED","KO_shot_face",4.0,0,1,1,1,0);
CMD:kostomach(playerid, params[]) return ApplyAnimation(playerid,"PED","KO_shot_stom",4.0,0,1,1,1,0);
CMD:lifejump(playerid, params[]) return ApplyAnimation(playerid,"PED","EV_dive",4.0,0,1,1,1,0);
CMD:cansado(playerid, params[]) return ApplyAnimation(playerid,"PED","IDLE_tired",3.0,1,0,0,0,0);
CMD:leftslap(playerid, params[]) return ApplyAnimation(playerid,"PED","BIKE_elbowL",4.0,0,0,0,0,0);
CMD:rolar(playerid, params[]) return ApplyAnimation(playerid,"PED","BIKE_fallR",4.0,0,1,1,1,0);
CMD:carlock(playerid, params[]) return ApplyAnimation(playerid,"PED","CAR_doorlocked_LHS",4.0,0,0,0,0,0);
CMD:rcarjack1(playerid, params[]) return ApplyAnimation(playerid,"PED","CAR_pulloutL_LHS",4.0,0,0,0,0,0);
CMD:lcarjack1(playerid, params[]) return ApplyAnimation(playerid,"PED","CAR_pulloutL_RHS",4.0,0,0,0,0,0);
CMD:rcarjack2(playerid, params[]) return ApplyAnimation(playerid,"PED","CAR_pullout_LHS",4.0,0,0,0,0,0);
CMD:lcarjack2(playerid, params[]) return ApplyAnimation(playerid,"PED","CAR_pullout_RHS",4.0,0,0,0,0,0);
CMD:hoodfrisked(playerid, params[]) return ApplyAnimation(playerid,"POLICE","crm_drgbst_01",4.0,0,1,1,1,0);
CMD:lightcig(playerid, params[]) return ApplyAnimation(playerid,"SMOKING","M_smk_in",3.0,0,0,0,0,0);
CMD:calma(playerid, params[]) return ApplyAnimation(playerid,"SMOKING","M_smk_tap",3.0,0,0,0,0,0);
CMD:bat(playerid, params[]) return ApplyAnimation(playerid,"BASEBALL","Bat_IDLE",4.0,1,1,1,1,0);
CMD:box(playerid, params[]) return ApplyAnimation(playerid,"GYMNASIUM","GYMshadowbox",4.0,1,1,1,1,0);
CMD:lay2(playerid, params[]) return ApplyAnimation(playerid,"SUNBATHE","Lay_Bac_in",3.0,0,1,1,1,0);
CMD:chant(playerid, params[]) return ApplyAnimation(playerid,"RIOT","RIOT_CHANT",4.0,1,1,1,1,0);
CMD:finger(playerid, params[]) return ApplyAnimation(playerid,"RIOT","RIOT_FUKU",2.0,0,0,0,0,0);
CMD:gritar(playerid, params[]) return ApplyAnimation(playerid,"RIOT","RIOT_shout",4.0,1,0,0,0,0);
CMD:cop(playerid, params[]) return ApplyAnimation(playerid,"SWORD","sword_block",50.0,0,1,1,1,1);
CMD:cutuvelada(playerid, params[]) return ApplyAnimation(playerid,"FIGHT_D","FightD_3",4.0,0,1,1,0,0);
CMD:kneekick(playerid, params[]) return ApplyAnimation(playerid,"FIGHT_D","FightD_2",4.0,0,1,1,0,0);
CMD:fstance(playerid, params[]) return ApplyAnimation(playerid,"FIGHT_D","FightD_IDLE",4.0,1,1,1,1,0);
CMD:gpunch(playerid, params[]) return ApplyAnimation(playerid,"FIGHT_B","FightB_G",4.0,0,0,0,0,0);
CMD:airkick(playerid, params[]) return ApplyAnimation(playerid,"FIGHT_C","FightC_M",4.0,0,1,1,0,0);
CMD:gkick(playerid, params[]) return ApplyAnimation(playerid,"FIGHT_D","FightD_G",4.0,0,0,0,0,0);
CMD:lowthrow(playerid, params[]) return ApplyAnimation(playerid,"GRENADE","WEAPON_throwu",3.0,0,0,0,0,0);
CMD:highthrow(playerid, params[]) return ApplyAnimation(playerid,"GRENADE","WEAPON_throw",4.0,0,0,0,0,0);
CMD:dealstance(playerid, params[]) return ApplyAnimation(playerid,"DEALER","DEALER_IDLE",4.0,1,0,0,0,0);
CMD:dancar(playerid, params[])
{
    new animid;
    if(sscanf(params,"d",animid)) return SendClientMessage(playerid, -1,"{FFFF00}/dancar [1-4]");
    switch(animid) {
    	case 1: SetPlayerSpecialAction(playerid, 5);
     	case 2: SetPlayerSpecialAction(playerid, 6);
        case 3: SetPlayerSpecialAction(playerid, 7);
        case 4: SetPlayerSpecialAction(playerid, 8);
        default: SendClientMessage(playerid, -1,"{FFFF00}/dance [stilo 1-4]");
   	}
	return 1;
}
CMD:dj(playerid, params[])
{
    new animid;
    if(sscanf(params,"d",animid)) return SendClientMessage(playerid, -1,"{FFFF00}/dj [1-4]");
    switch(animid) {
    	case 1: ApplyAnimation(playerid, "SCRATCHING", "scdldlp", 4.0, 1, 0, 0, 0, 0);
        case 2: ApplyAnimation(playerid, "SCRATCHING", "scdlulp", 4.0, 1, 0, 0, 0, 0);
        case 3: ApplyAnimation(playerid, "SCRATCHING", "scdrdlp", 4.0, 1, 0, 0, 0, 0);
        case 4: ApplyAnimation(playerid, "SCRATCHING", "scdrulp", 4.0, 1, 0, 0, 0, 0);
        default: SendClientMessage(playerid, -1,"{FFFF00}/dj [1-4]");
   	}
	return 1;
}

CMD:sup(playerid, params[])
{
    new animid;
    if(sscanf(params,"d",animid)) return SendClientMessage(playerid, -1,"{FFFF00}/sup [1-3]");
    switch(animid) {
    	case 1: ApplyAnimation(playerid,"GANGS","hndshkba",4.0,0,0,0,0,0);
        case 2: ApplyAnimation(playerid,"GANGS","hndshkda",4.0,0,0,0,0,0);
        case 3: ApplyAnimation(playerid,"GANGS","hndshkfa_swt",4.0,0,0,0,0,0);
        default: SendClientMessage(playerid, -1,"{FFFF00}/sup [1-3]");
   	}
	return 1;
}

CMD:basket(playerid, params[])
{
    new animid;
    if(sscanf(params,"d",animid)) return SendClientMessage(playerid, -1,"{FFFF00}/basket [1-6]");
    switch(animid) {
    	case 1: ApplyAnimation(playerid,"BSKTBALL","BBALL_idleloop",4.0,1,0,0,0,0);
        case 2: ApplyAnimation(playerid,"BSKTBALL","BBALL_Jump_Shot",4.0,0,0,0,0,0);
        case 3: ApplyAnimation(playerid,"BSKTBALL","BBALL_pickup",4.0,0,0,0,0,0);
        case 4: ApplyAnimation(playerid,"BSKTBALL","BBALL_run",4.1,1,1,1,1,1);
        case 5: ApplyAnimation(playerid,"BSKTBALL","BBALL_def_loop",4.0,1,0,0,0,0);
        case 6: ApplyAnimation(playerid,"BSKTBALL","BBALL_Dnk",4.0,1,0,0,0,0);
        default: SendClientMessage(playerid, -1,"{FFFF00}/basket [1-6]");
   	}
	return 1;
}

CMD:knife(playerid, params[])
{
    new animid;
    if(sscanf(params,"d",animid)) return SendClientMessage(playerid, -1,"{FFFF00}/knife [1-4]");
    switch(animid) {
        case 1: ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Damage",4.0,0,1,1,1,0);
        case 2: ApplyAnimation(playerid,"KNIFE","KILL_Knife_Ped_Die",4.0,0,1,1,1,0);
        case 3: ApplyAnimation(playerid,"KNIFE","KILL_Knife_Player",4.0,0,0,0,0,0);
        case 4: ApplyAnimation(playerid,"KNIFE","KILL_Partial",4.0,0,1,1,1,1);
        default: SendClientMessage(playerid, -1,"{FFFF00}/knife [1-4]");
   	}
	return 1;
}

CMD:beijar(playerid, params[]){ApplyAnimation(playerid,"KISSING", "Grlfrd_Kiss_02", 1.800001, 1, 0, 0, 1, 600);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:stop(playerid, params[]){ApplyAnimation(playerid, "PED", "endchat_01", 4.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:punheta(playerid, params[]){ApplyAnimation(playerid, "PAULNMAC", "wank_out", 4.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:handsup(playerid, params[]){SetPlayerSpecialAction(playerid, SPECIAL_ACTION_HANDSUP);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:ligar(playerid, params[]){SetPlayerSpecialAction(playerid, 11);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:desligar(playerid, params[]){SetPlayerSpecialAction(playerid, 13);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:bebado(playerid, params[]){ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:bomba(playerid, params[]){ClearAnimations(playerid);ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:apontar(playerid, params[]){ApplyAnimation(playerid, "ped", "ARRESTgun", 4.0, 0, 1, 1, 1, -1);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:merda(playerid, params[]){ApplyAnimation(playerid, "RAPPING", "Laugh_01", 4.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:marcararse(playerid, params[]){ApplyAnimation(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:roubar(playerid, params[]){ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:cruzarb(playerid, params[]){ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:deitar(playerid, params[]){ApplyAnimation(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:abaixar(playerid, params[]){ApplyAnimation(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:vomitar(playerid, params[]){ApplyAnimation(playerid, "FOOD", "EAT_Vomit_P", 3.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:comer(playerid, params[]){ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:rap(playerid, params[]){ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:passaramao(playerid, params[]){ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:cobrar(playerid, params[]){ApplyAnimation(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:oberdose(playerid, params[]){ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:fumar(playerid, params[]){ApplyAnimation(playerid, "SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:fumar2(playerid, params[]){ApplyAnimation(playerid, "SMOKING", "F_smklean_loop", 4.0, 1, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:sentar(playerid, params[]){ApplyAnimation(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:conversar(playerid, params[]){ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:fodase(playerid, params[]){ApplyAnimation(playerid, "PED", "fucku", 4.0, 0, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:taichi(playerid, params[]){ApplyAnimation(playerid, "PARK", "Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:observar(playerid, params[]){ApplyAnimation(playerid, "BAR", "dnk_stndF_loop", 4.0, 1, 0, 0, 0, 0);SendClientMessage(playerid, -1, "(Info) Use /Pararanim para parar a animação");return 1;}
CMD:pararanim(playerid, params[]){ClearAnimations(playerid);SendClientMessage(playerid, -1, "(Info) animação foi parada com sucesso");return 1;}
/* Animes by Delete ^ */



CMD:status(playerid, params[]) {
	for(new i; i < 11; i++) {
		if(PlayerInfo[playerid][DrawStatus][i] == PlayerText:INVALID_TEXT_DRAW) continue;
		PlayerTextDrawDestroy(playerid, PlayerInfo[playerid][DrawStatus][i]);
		PlayerInfo[playerid][DrawStatus][i] = PlayerText:INVALID_TEXT_DRAW;
	}
	return nick_DrawsStatus(playerid);
}
CMD:teclasveiculo(playerid, params[]) {
	PlayerInfo[playerid][Teclas] = (PlayerInfo[playerid][Teclas] == true) ? (false) : (true);
	SendClientMessage(playerid, -1, (PlayerInfo[playerid][Teclas] == true) ? ("{ffff00}Teclas do veículo ativas!") : ("{ff0000}Teclas do veículo desativadas!"));
	return 1;
}
/*********************************
    Teleportes (comandos)
**********************************/
//Stunts
CMD:chiliad(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 0, "");
CMD:aeroabandonado(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 1, "");
CMD:represa(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 2, "");
CMD:aerols(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 3, "");
CMD:praiasm(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 4, "");
CMD:pirataslv(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 5, "");
CMD:easterboard(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 6, "");
CMD:sfstunt(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 7, "");
CMD:aerosf(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 8, "");
CMD:aerolv(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 9, "");
CMD:golf(playerid, params[]) return OnDialogResponse(playerid, DialogTeleStunt, 1, 10, "");
//Pistas
CMD:drop1(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 0, "");
CMD:drop2(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 1, "");
CMD:drop3(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 2, "");
CMD:drop4(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 3, "");
CMD:twister(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 4, "");
CMD:loop(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 5, "");
CMD:loop2(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 6, "");
CMD:insano1(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 7, "");
CMD:insano2(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 8, "");
CMD:insano3(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 9, "");
CMD:roller(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 10, "");
CMD:ip(playerid, params[]) return OnDialogResponse(playerid, DialogTelePistas, 1, 11, "");
//Normais
CMD:lossantos(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 0, "");
CMD:lstransfender(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 1, "");
CMD:lslow(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 2, "");
CMD:sanfierro(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 3, "");
CMD:sftransfender(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 4, "");
CMD:sftunning(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 5, "");
CMD:lasventuras(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 6, "");
CMD:lvtransfender(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 7, "");
CMD:bayside(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 8, "");
CMD:angelpine(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 9, "");
CMD:elquebrados(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 10, "");
CMD:lasbarrancas(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 11, "");
CMD:fortcarson(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 12, "");
CMD:blueberry(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 13, "");
CMD:dillimore(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 14, "");
CMD:palomino(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 15, "");
CMD:montgomery(playerid, params[]) return OnDialogResponse(playerid, DialogTeleNormal, 1, 16, "");
//Drift
CMD:drift1(playerid, params[]) return OnDialogResponse(playerid, DialogTeleDrift, 1, 0, "");
CMD:drift2(playerid, params[]) return OnDialogResponse(playerid, DialogTeleDrift, 1, 1, "");
//Pulos
CMD:puloinsano(playerid, params[]) return OnDialogResponse(playerid, DialogTelePulos, 1, 0, "");
CMD:bigtunel(playerid, params[]) return OnDialogResponse(playerid, DialogTelePulos, 1, 1, "");
CMD:superrampa(playerid, params[]) return OnDialogResponse(playerid, DialogTelePulos, 1, 2, "");
CMD:sky(playerid, params[]) return OnDialogResponse(playerid, DialogTelePulos, 1, 3, ""), GivePlayerWeapon(playerid, 46, 1);
//Corridas
CMD:nascar(playerid, params[]) return OnDialogResponse(playerid, DialogTeleCorridas, 1, 1, "");
CMD:drag(playerid, params[]) return OnDialogResponse(playerid, DialogTeleCorridas, 1, 0, "");
CMD:circuitolv(playerid, params[]) return OnDialogResponse(playerid, DialogTeleCorridas, 1, 2, "");
//Tubos
CMD:tuboagua(playerid, params[]) return OnDialogResponse(playerid, DialogTeleTubos, 1, 0, "");
CMD:espiral(playerid, params[]) return OnDialogResponse(playerid, DialogTeleTubos, 1, 1, "");
CMD:tubosf(playerid, params[]) return OnDialogResponse(playerid, DialogTeleTubos, 1, 2, "");
//Variados
CMD:trampolim(playerid, params[]) return OnDialogResponse(playerid, DialogTeleVariado, 1, 0, "");
CMD:festa(playerid, params[]) return OnDialogResponse(playerid, DialogTeleVariado, 1, 1, "");
CMD:monsterpk(playerid, params[]) return OnDialogResponse(playerid, DialogTeleVariado, 1, 2, "");
//Arenas
CMD:minigun(playerid, params[]) return OnDialogResponse(playerid, DialogArenasDM, 1, 0, "");
CMD:ak47(playerid, params[]) return OnDialogResponse(playerid, DialogArenasDM, 1, 1, "");


/*********************************
			Veiculos
**********************************/

stock Veiculos() {
    //Delete
	//circuito lv
	AddStaticVehicle(502,3257.50000000,1207.90002441,18.10000038,11.75000000,-1,-1); //Hotring Racer A
	AddStaticVehicle(502,3265.60009766,1210.09997559,18.10000038,11.74987793,-1,-1); //Hotring Racer A
	AddStaticVehicle(502,3273.89990234,1212.30004883,18.10000038,11.74987793,-1,-1); //Hotring Racer A
	AddStaticVehicle(502,3283.10009766,1214.19995117,18.10000038,11.74987793,-1,-1); //Hotring Racer A
	AddStaticVehicle(502,3292.30004883,1215.80004883,18.10000038,11.74987793,-1,-1); //Hotring Racer A
	AddStaticVehicle(502,3304.80004883,1218.50000000,18.10000038,11.74987793,-1,-1); //Hotring Racer A

	//fazenda stuntings
	AddStaticVehicle(522,-16.5111,15.1283,2.6780,339.8763,39,106); // spawn fazenda
	AddStaticVehicle(522,-14.6987,14.4642,2.6838,339.8743,39,106); // spawn fazenda
	AddStaticVehicle(522,-12.9142,13.8103,2.6838,339.8743,39,106); // spawn fazenda
	AddStaticVehicle(522,-11.4165,13.2614,2.6838,339.8743,39,106); // spawn fazenda
	AddStaticVehicle(522,-9.7104,12.6362,2.6838,339.8743,39,106); // spawn fazenda
	AddStaticVehicle(522,-8.1566,12.0668,2.6838,339.8743,39,106); // spawn fazenda

	//insano
	AddStaticVehicle(411,-2524.4468,146.4595,3230.6370,359.8078,64,1); // insano veiculos
	AddStaticVehicle(411,-2515.7087,146.4205,3230.6499,359.8078,64,1); // insano veiculos
	AddStaticVehicle(411,-2535.2263,146.4722,3230.6643,359.8078,64,1); // insano veiculos
	AddStaticVehicle(411,-2544.5007,146.5179,3230.6777,359.8078,64,1); // insano veiculos

	//nascar
	AddStaticVehicle(411,1799.09997559,-2382.80004883,486.00000000,94.25000000,-1,-1); //Infernus
	AddStaticVehicle(411,1798.80004883,-2376.60009766,486.00000000,94.24621582,-1,-1); //Infernus
	AddStaticVehicle(411,1798.50000000,-2370.19995117,486.00000000,94.24621582,-1,-1); //Infernus
	AddStaticVehicle(411,1797.80004883,-2363.89990234,486.00000000,94.24621582,-1,-1); //Infernus
	AddStaticVehicle(411,1797.59997559,-2357.39990234,486.00000000,94.24621582,-1,-1); //Infernus
	AddStaticVehicle(411,1797.19995117,-2351.00000000,486.00000000,94.24621582,-1,-1); //Infernus
	AddStaticVehicle(411,1796.90002441,-2344.60009766,486.00000000,94.24621582,-1,-1); //Infernus

	//drag
	AddStaticVehicle(411,2547.50000000,-230.89999390,71.00000000,80.00000000,-1,-1); //Infernus
	AddStaticVehicle(411,2555.10009766,-234.80000305,71.00000000,79.99694824,-1,-1); //Infernus
	AddStaticVehicle(411,2557.80004883,-240.19999695,71.00000000,79.99694824,-1,-1); //Infernus
	AddStaticVehicle(411,2557.80004883,-247.60000610,71.00000000,79.99694824,-1,-1); //Infernus
	AddStaticVehicle(411,2553.10009766,-255.30000305,71.00000000,79.99694824,-1,-1); //Infernus
	AddStaticVehicle(411,2543.10009766,-256.79998779,71.00000000,79.99694824,-1,-1); //Infernus

	//espiral
	AddStaticVehicle(495,223.1265,860.6835,363.0637,0.2217,119,122); // espiral
	AddStaticVehicle(495,248.6065,860.1947,363.0511,359.4057,119,122); // espiral
	AddStaticVehicle(495,263.8384,842.1574,363.0563,91.0103,119,122); // espiral
	AddStaticVehicle(495,202.5332,841.7902,363.0602,269.7198,119,122); // espiral

	//superrampa
    AddStaticVehicle(411,1453.80004883,-2405.30004883,1122.09997559,262.00000000,-1,-1); //Infernus
	AddStaticVehicle(411,1452.90002441,-2411.80004883,1122.09997559,261.99645996,-1,-1); //Infernus
	AddStaticVehicle(415,1451.59997559,-2421.10009766,1122.19995117,259.75000000,-1,-1); //Cheetah
	AddStaticVehicle(411,1451.50000000,-2427.69995117,1122.09997559,261.99645996,-1,-1); //Infernus
	AddStaticVehicle(411,1450.40002441,-2433.89990234,1122.09997559,261.99645996,-1,-1); //Infernus

	//loop
	AddStaticVehicle(411,3324.10009766,-2505.00000000,736.09997559,289.00000000,-1,-1); //Infernus
	AddStaticVehicle(411,3326.10009766,-2511.00000000,736.09997559,288.99536133,-1,-1); //Infernus
	AddStaticVehicle(411,3327.89990234,-2517.30004883,736.09997559,288.99536133,-1,-1); //Infernus
	AddStaticVehicle(411,3330.10009766,-2523.30004883,736.09997559,288.99536133,-1,-1); //Infernus
	AddStaticVehicle(411,3332.30004883,-2529.30004883,736.09997559,288.99536133,-1,-1); //Infernus

	//loop2
	AddStaticVehicle(411,-182.89999390,995.09997559,1312.40002441,180.25000000,-1,-1); //Infernus
	AddStaticVehicle(411,-189.10000610,995.50000000,1312.40002441,180.24719238,-1,-1); //Infernus
	AddStaticVehicle(411,-195.69999695,995.50000000,1312.40002441,180.24719238,-1,-1); //Infernus
	AddStaticVehicle(411,-202.00000000,995.50000000,1312.40002441,180.24719238,-1,-1); //Infernus
	AddStaticVehicle(411,-208.50000000,995.50000000,1312.40002441,180.24719238,-1,-1); //Infernus
	AddStaticVehicle(411,-215.00000000,995.40002441,1312.40002441,180.24719238,-1,-1); //Infernus

	//drift1
	AddStaticVehicle(562,-327.29998779,1515.80004883,75.09999847,0.00000000,-1,-1); //Elegy
	AddStaticVehicle(562,-342.89941406,1515.69921875,75.09999847,0.00000000,-1,-1); //Elegy
	AddStaticVehicle(562,-339.69921875,1515.69921875,75.09999847,0.00000000,-1,-1); //Elegy
	AddStaticVehicle(562,-336.69921875,1515.59960938,75.09999847,0.00000000,-1,-1); //Elegy
	AddStaticVehicle(562,-333.59960938,1515.69921875,75.09999847,0.00000000,-1,-1); //Elegy
	AddStaticVehicle(562,-330.29980469,1515.69921875,75.09999847,0.00000000,-1,-1); //Elegy
	AddStaticVehicle(562,-302.70001221,1579.80004883,75.09999847,136.00000000,-1,-1); //Elegy
	AddStaticVehicle(562,-300.00000000,1577.09997559,75.09999847,135.99975586,-1,-1); //Elegy
	AddStaticVehicle(562,-297.60000610,1574.90002441,75.09999847,135.99975586,-1,-1); //Elegy
	AddStaticVehicle(562,-295.10000610,1572.50000000,75.09999847,135.99975586,-1,-1); //Elegy

 	//praia

 	AddStaticVehicle(522,324.7022,-1787.3041,4.3564,178.3763,51,118); // veícuos praia
	AddStaticVehicle(522,321.3780,-1788.1775,4.3057,178.6476,51,118); // veícuos praia
	AddStaticVehicle(522,318.3364,-1788.2188,4.2527,179.7327,51,118); // veícuos praia
	AddStaticVehicle(522,315.0172,-1787.8624,4.2047,180.5475,51,118); // veícuos praia
	AddStaticVehicle(522,311.5652,-1787.5649,4.1532,179.1864,51,118); // veícuos praia

	//aquatubo

    AddStaticVehicle(411,-272.5742,375.9751,-35.5151,77.8616,123,1); // aquatubo
	AddStaticVehicle(411,-274.5762,370.4649,-35.5151,79.7328,123,1); // aquatubo
	AddStaticVehicle(411,-275.3676,367.0325,-35.5151,81.3952,123,1); // aquatubo
	AddStaticVehicle(411,-286.5009,308.9572,-35.5175,351.7867,123,1); // aquatubo
	AddStaticVehicle(411,-291.7205,309.3366,-35.5175,350.8400,123,1); // aquatubo
	AddStaticVehicle(411,-318.2276,328.0358,-35.5151,80.2177,123,1); // aquatubo

	//drop

	AddStaticVehicle(411,833.09997559,-2586.19995117,798.40002441,272.00000000,-1,-1); //Infernus
	AddStaticVehicle(411,833.09997559,-2593.00000000,798.40002441,271.99951172,-1,-1); //Infernus
	AddStaticVehicle(411,833.09997559,-2599.30004883,798.40002441,271.99951172,-1,-1); //Infernus
	AddStaticVehicle(411,833.29998779,-2605.60009766,798.40002441,271.99951172,-1,-1); //Infernus
	AddStaticVehicle(411,833.90002441,-2611.89990234,798.40002441,271.99951172,-1,-1); //Infernus
	AddStaticVehicle(411,833.90002441,-2618.69995117,798.40002441,271.99951172,-1,-1); //Infernus

	//drop2

	AddStaticVehicle(411,3830.30004883,-1073.80004883,929.90002441,0.00000000,-1,-1); //Infernus
	AddStaticVehicle(411,3836.69995117,-1073.90002441,929.90002441,0.00000000,-1,-1); //Infernus
	AddStaticVehicle(411,3824.09960938,-1074.00000000,929.90002441,0.00000000,-1,-1); //Infernus
	AddStaticVehicle(411,3843.00000000,-1073.30004883,929.90002441,0.00000000,-1,-1); //Infernus
	AddStaticVehicle(411,3849.50000000,-1073.50000000,929.90002441,0.00000000,-1,-1); //Infernus
	AddStaticVehicle(411,3865.60009766,-1073.40002441,929.90002441,0.00000000,-1,-1); //Infernus

	//drop3
	AddStaticVehicle(411,977.09997559,1736.69995117,1012.29998779,88.50000000,-1,-1); //Infernus
	AddStaticVehicle(411,977.50000000,1742.59997559,1012.29998779,88.49487305,-1,-1); //Infernus
	AddStaticVehicle(411,968.70001221,1742.59997559,1012.29998779,88.49487305,-1,-1); //Infernus
	AddStaticVehicle(411,968.70001221,1736.80004883,1012.29998779,88.49487305,-1,-1); //Infernus
	AddStaticVehicle(411,960.59997559,1736.90002441,1012.29998779,88.49487305,-1,-1); //Infernus
	AddStaticVehicle(411,960.70001221,1742.90002441,1012.29998779,88.49487305,-1,-1); //Infernus

	//drop4
	AddStaticVehicle(411,1264.6095,2756.8838,1554.6814,89.4813,64,1); // drop4
	AddStaticVehicle(411,1264.4979,2763.3962,1554.6814,89.7153,64,1); // drop4
	AddStaticVehicle(411,1264.4875,2769.8015,1554.6813,90.2916,64,1); // drop4
	AddStaticVehicle(411,1264.2904,2776.1975,1554.6815,89.4880,64,1); // drop4
	AddStaticVehicle(411,1264.1796,2788.8767,1554.6815,90.9055,64,1); // drop4

 	//jizzy
 	AddStaticVehicle(522,-2616.69995117,1378.40002441,6.80000019,182.00000000,-1,-1); //NRG-500
	AddStaticVehicle(522,-2618.60009766,1378.19995117,6.80000019,181.99951172,-1,-1); //NRG-500
	AddStaticVehicle(522,-2620.50000000,1378.00000000,6.80000019,181.99951172,-1,-1); //NRG-500
	AddStaticVehicle(522,-2622.60009766,1377.90002441,6.80000019,181.99951172,-1,-1); //NRG-500
	AddStaticVehicle(522,-2624.19995117,1377.80004883,6.80000019,181.99951172,-1,-1); //NRG-500
	AddStaticVehicle(522,-2626.00000000,1377.80004883,6.80000019,181.99951172,-1,-1); //NRG-500
	AddStaticVehicle(522,-2627.60009766,1377.80004883,6.80000019,181.99951172,-1,-1); //NRG-500
	//aerolv
	AddStaticVehicle(522,1290.59997559,1371.19995117,10.50000000,266.00000000,-1,-1); //NRG-500
	AddStaticVehicle(522,1290.50000000,1368.69995117,10.50000000,265.99548340,-1,-1); //NRG-500
	AddStaticVehicle(522,1290.40002441,1365.90002441,10.50000000,265.99548340,-1,-1); //NRG-500
	AddStaticVehicle(522,1290.59997559,1362.90002441,10.50000000,265.99548340,-1,-1); //NRG-500
	AddStaticVehicle(522,1290.80004883,1360.09997559,10.50000000,265.99548340,-1,-1); //NRG-500
	AddStaticVehicle(522,1290.50000000,1356.90002441,10.50000000,265.99548340,-1,-1); //NRG-500
	//aerosf
	AddStaticVehicle(522,-1424.90002441,-124.40000153,13.80000019,344.00000000,-1,-1); //NRG-500
	AddStaticVehicle(522,-1422.40002441,-124.69999695,13.80000019,343.99841309,-1,-1); //NRG-500
	AddStaticVehicle(522,-1420.09997559,-125.69999695,13.80000019,343.99841309,-1,-1); //NRG-500
	AddStaticVehicle(522,-1417.69995117,-126.50000000,13.80000019,343.99841309,-1,-1); //NRG-500
	AddStaticVehicle(522,-1415.40002441,-127.50000000,13.80000019,343.99841309,-1,-1); //NRG-500
	AddStaticVehicle(522,-1413.00000000,-128.00000000,13.80000019,343.99841309,-1,-1); //NRG-500
	//barrage
	AddStaticVehicle(522,-458.50000000,2229.19995117,43.00000000,122.00000000,-1,-1); //NRG-500
	AddStaticVehicle(522,-459.60000610,2230.89990234,43.00000000,121.99768066,-1,-1); //NRG-500
	AddStaticVehicle(522,-461.00000000,2233.00000000,43.00000000,121.99768066,-1,-1); //NRG-500
	AddStaticVehicle(522,-462.50000000,2235.30004883,43.00000000,121.99768066,-1,-1); //NRG-500
	AddStaticVehicle(522,-463.60000610,2237.60009766,43.79999924,121.99768066,-1,-1); //NRG-500
	AddStaticVehicle(522,-464.39999390,2239.60009766,44.20000076,121.99768066,-1,-1); //NRG-500
	//aeroabandonado
	AddStaticVehicle(522,402.48140000,2530.22750000,16.13910000,177.84100000,3,8); //NRG-500
	AddStaticVehicle(522,400.33420000,2529.89280000,16.12650000,181.70090000,3,8); //NRG-500
	AddStaticVehicle(522,397.56880000,2530.26880000,16.12540000,178.65880000,3,8); //NRG-500
	AddStaticVehicle(522,395.37600000,2530.55540000,16.10690000,178.55900000,3,8); //NRG-500
	AddStaticVehicle(522,392.68360000,2529.99950000,16.11930000,179.18370000,3,8); //NRG-500
	AddStaticVehicle(522,390.48500000,2529.98440000,16.11370000,177.53730000,3,8); //NRG-500
	//bayside
	AddStaticVehicle(522,-2251.3503,2294.0190,4.3710,87.1628,7,79); // bayside
	AddStaticVehicle(522,-2251.6069,2297.1360,4.3804,95.5798,7,79); // bayside
	AddStaticVehicle(522,-2251.3018,2300.0413,4.3829,89.9709,7,79); // bayside
	AddStaticVehicle(522,-2251.1250,2302.8745,4.3825,90.9840,7,79); // bayside
	AddStaticVehicle(522,-2251.3787,2305.9006,4.3808,91.5309,7,79); // bayside

	//barco pirata
	AddStaticVehicle(522,1986.6515,1461.7920,10.3913,1.0002,36,105); // barco
	AddStaticVehicle(522,1984.5958,1461.7690,10.3797,358.3215,36,105); // barco
	AddStaticVehicle(522,1981.8933,1461.6594,10.3816,1.2725,36,105); // barco
	AddStaticVehicle(522,1979.1884,1461.6415,10.3898,0.1700,36,105); // barco
    AddStaticVehicle(522,1974.6509,1461.4113,10.3883,358.4709,36,105); // barco

    //trampolim
    AddStaticVehicle(573,979.7058,1225.9103,410.6503,42.4122,115,43); // trampolim
	AddStaticVehicle(573,985.1293,1230.4868,410.6504,39.4075,115,43); // trampolim
	AddStaticVehicle(573,988.7131,1232.6423,410.6504,41.5853,115,43); // trampolim
	AddStaticVehicle(573,991.6682,1235.1875,410.6503,40.4154,115,43); // trampolim
	AddStaticVehicle(573,994.2393,1237.8129,410.6504,40.2649,115,43); // trampolim
	AddStaticVehicle(573,997.2834,1240.4061,410.6505,41.1547,115,43); // trampolim

	//insano 2
	AddStaticVehicle(411,891.6823,875.0927,934.8451,1.5995,116,1); // insano 2
	AddStaticVehicle(411,881.5996,874.6905,934.8652,355.4582,112,1); // insano 2

	AddStaticVehicle(522,-1606.4841,-725.1211,1527.3544,87.7146,7,79); // insano3 motos
	AddStaticVehicle(522,-1606.6803,-728.2292,1527.3579,92.9512,7,79); // insano3 motos
	AddStaticVehicle(522,-1606.3787,-731.3755,1527.3563,89.9688,7,79); // insano3 motos
	AddStaticVehicle(522,-1606.5819,-734.3317,1527.3545,89.3513,7,79); // insano3 motos
	AddStaticVehicle(522,-1606.7711,-737.3712,1527.3552,92.2349,7,79); // insano3 motos
	AddStaticVehicle(411,-1615.3507,-748.1603,1527.5114,358.3741,123,1); // insano3 carros
	AddStaticVehicle(411,-1618.4652,-748.2435,1527.5116,359.5027,123,1); // insano3 carros
	AddStaticVehicle(411,-1621.6663,-748.1735,1527.5116,358.1227,123,1); // insano3 carros
	AddStaticVehicle(411,-1624.9395,-748.1094,1527.5116,357.5916,123,1); // insano3 carros
	AddStaticVehicle(411,-1628.0664,-748.3564,1527.5115,0.4689,123,1); // insano3 carros

	//bigtunel
	AddStaticVehicle(402,2202.19995117,1518.00000000,3864.39990234,182.00000000,-1,-1); //Buffalo
	AddStaticVehicle(601,2207.19995117,1525.30004883,3864.39990234,180.00000000,-1,-1); //S.W.A.T. Van
	AddStaticVehicle(599,2212.69995117,1523.50000000,3864.80004883,180.00000000,-1,-1); //Police Ranger
	AddStaticVehicle(544,2219.60009766,1519.69995117,3864.80004883,176.00000000,-1,-1); //Firetruck LA
	AddStaticVehicle(528,2225.80004883,1513.19995117,3864.30004883,170.00000000,-1,-1); //FBI Truck
	AddStaticVehicle(455,2221.39990234,1505.00000000,3865.10009766,160.00000000,-1,-1); //Flatbed
	AddStaticVehicle(406,2207.10009766,1507.00000000,3865.30004883,180.00000000,-1,-1); //Dumper
    return 1;
}

forward SemFlood(playerid);
public SemFlood(playerid)
{
    IsFlooding[playerid] = 0;
    return 1;
}

forward LiberarChat(playerid);
public LiberarChat(playerid)
{
    Flooder[playerid] = 0;
    SendClientMessage(playerid, 0x60BFFFAA, "{FFFF00}[INFO] {009D4F}Você foi descalado, não faça mais flood !");
    return 1;
}

