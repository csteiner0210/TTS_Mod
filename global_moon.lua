--[[ Lua code. See documentation: https://api.tabletopsimulator.com/ --]]

--[[ The onLoad event is called after the game save finishes loading. --]]

--Scripting by OlePapVanWinkle.  Graphic Design and Modeling by Kungfuquickness
--and Johnny9Fingers.  UI and UX enhancements by Kelzone52


--------------------------------GUID Definitions
ReactorDeck_GUID = '4c5d63'
ThrusterDeck_GUID = '74dc36'
ShieldDeck_GUID = '6a5dc7'
Damage1Deck_GUID = '6102db'
Damage2Deck_GUID = '509c2a'
Damage3Deck_GUID = '9849fc'
MissDeck_GUID = '66d82c'

CrewDeck_GUID = 'fecc88'
ShipPartsDeck_GUID = '5f9c85'
ObjectivesDeck_GUID = '9625df'
ContractsDeck_GUID = '3cab0b'
T2ContractsDeck_GUID = '9a9887'


ArmoryMat_GUID = '80f573'
DispatchMat_GUID = '461c5c'

PurpleShip_GUID = 'ede470'
BlueShip_GUID = 'd3306c'
GreenShip_GUID = '5eb7ab'
YellowShip_GUID = 'e43161'
OrangeShip_GUID = '02dc9f'

PurpleDeckZone_GUID = '6bce9e'
BlueDeckZone_GUID = 'd36c7b'
GreenDeckZone_GUID = '84091c'
YellowDeckZone_GUID = '2d5287'
OrangeDeckZone_GUID = 'e1a312'

ActiveContractZone_GUID = '7f8fed'

Credits3_GUID = 'db1958'
Credits1_GUID = 'aa7795'

StartGameImage_GUID = '3fb83c'
YesImage_GUID = 'be4bdf'
NoImage_GUID = 'f1a4f8'

FirstEncounterBox_GUID = 'f9bdd4'
FirstEncounterShip_GUID = '302969'
FirstEncounterCrew_GUID = '71c5db'
FirstEncounterContracts_GUID = 'a84db8'

FirstEncounter_GUID = 'b4ce27'
FirstEncounterToken_GUID = '5e9a0a'

--------------------------------Button parameters

GameSetup_parameters = {}
GameSetup_parameters.click_function = 'GameSetupPhase1'
GameSetup_parameters.function_owner = nil
GameSetup_parameters.position = {0,0.8,0}
GameSetup_parameters.rotation = {0,0,0}
GameSetup_parameters.width = 3400
GameSetup_parameters.height = 1000
GameSetup_parameters.font_size = 80
GameSetup_parameters.color = {1,1,1,0}

NoButton_parameters = {}
NoButton_parameters.click_function = 'GameSetupCancel'
NoButton_parameters.function_owner = nil
NoButton_parameters.position = {0,0.2,0}
NoButton_parameters.width = 1000
NoButton_parameters.height = 1000
NoButton_parameters.color = {1,1,1,0}

YesButton_parameters = {}
YesButton_parameters.click_function = 'GameSetup'
YesButton_parameters.function_owner = nil
YesButton_parameters.position = {0,0.2,0}
YesButton_parameters.width = 1000
YesButton_parameters.height = 1000
YesButton_parameters.color = {1,1,1,0}

FirstEncounter_parameters = {}
FirstEncounter_parameters.click_function = "FirstEncounterToggle"
FirstEncounter_parameters.function_owner = nil
FirstEncounter_parameters.position = {-0.8,0.4,0}
FirstEncounter_parameters.width = 2680
FirstEncounter_parameters.height = 620
FirstEncounter_parameters.color = {1,1,1,0}

--------------------------------Save Data

function onSave()
    saved_data = JSON.encode({["GameStartedSaved"] = GameStarted})
    --saved_data = "" --Remove -- at start & save to clear save data_to_save
    return saved_data
end

--------------------------------Initial Load

function onLoad(saved_data)
math.randomseed( os.time() )
---------------------Check for save and set GameStarted variable
    if saved_data ~= "" then
        loaded_data = JSON.decode(saved_data)
        GameStarted = loaded_data.GameStartedSaved
    else
        GameStarted = 0
    end
---------------------Define Objects
ReactorDeck = getObjectFromGUID(ReactorDeck_GUID)
ThrusterDeck = getObjectFromGUID(ThrusterDeck_GUID)
ShieldDeck = getObjectFromGUID(ShieldDeck_GUID)
Damage1Deck = getObjectFromGUID(Damage1Deck_GUID)
Damage2Deck = getObjectFromGUID(Damage2Deck_GUID)
Damage3Deck = getObjectFromGUID(Damage3Deck_GUID)
MissDeck = getObjectFromGUID(MissDeck_GUID)

CrewDeck = getObjectFromGUID(CrewDeck_GUID)
ShipPartsDeck = getObjectFromGUID(ShipPartsDeck_GUID)
ObjectivesDeck = getObjectFromGUID(ObjectivesDeck_GUID)
ContractsDeck = getObjectFromGUID(ContractsDeck_GUID)
T2ContractsDeck = getObjectFromGUID(T2ContractsDeck_GUID)

ArmoryMat = getObjectFromGUID(ArmoryMat_GUID)
DispatchMat = getObjectFromGUID(DispatchMat_GUID)

PurpleShip = getObjectFromGUID(PurpleShip_GUID)
BlueShip = getObjectFromGUID(BlueShip_GUID)
GreenShip = getObjectFromGUID(GreenShip_GUID)
YellowShip = getObjectFromGUID(YellowShip_GUID)
OrangeShip = getObjectFromGUID(OrangeShip_GUID)

PurpleDeckZone = getObjectFromGUID(PurpleDeckZone_GUID)
BlueDeckZone = getObjectFromGUID(BlueDeckZone_GUID)
GreenDeckZone = getObjectFromGUID(GreenDeckZone_GUID)
YellowDeckZone = getObjectFromGUID(YellowDeckZone_GUID)
OrangeDeckZone = getObjectFromGUID(OrangeDeckZone_GUID)

ActiveContractZone = getObjectFromGUID(ActiveContractZone_GUID)

Credits3 = getObjectFromGUID(Credits3_GUID)
Credits1 = getObjectFromGUID(Credits1_GUID)

FirstEncounterBox = getObjectFromGUID(FirstEncounterBox_GUID)
FirstEncounterShip = getObjectFromGUID(FirstEncounterShip_GUID)
FirstEncounterCrew = getObjectFromGUID(FirstEncounterCrew_GUID)
FirstEncounterContracts = getObjectFromGUID(FirstEncounterContracts_GUID)

FE = 0 -- Initial Value for First Encounter Expansion Toggle

---------------------Create Buttons
if GameStarted == 0 then
    StartGameImage = getObjectFromGUID(StartGameImage_GUID)
    NoImage = getObjectFromGUID(NoImage_GUID)
    YesImage = getObjectFromGUID(YesImage_GUID)
    FirstEncounter = getObjectFromGUID(FirstEncounter_GUID)
    FirstEncounterToken = getObjectFromGUID(FirstEncounterToken_GUID)
    StartGameImage.createButton(GameSetup_parameters)
    FirstEncounter.createButton(FirstEncounter_parameters)
    FirstEncounterBox.setPosition({-90,150,20})
else
end

end


--------------------------------Game Setup Functions

function FirstEncounterToggle()
    FirstEncounterToken.setLock(false)
    FirstEncounterToken.flip()
    Wait.time(function() FirstEncounterToken.setLock(true) end, 0.5)
    if FE == 0 then FE = 1 else
        if FE == 1 then FE = 0
        end
    end
end


---------------------First Button Click
function GameSetupPhase1()
    StartGameImage.removeButton(0)
    Wait.frames(function() printToAll("..") end, 2)
    Wait.frames(function() printToAll("...") end, 4)
    Wait.frames(function() printToAll("..") end, 6)
    Wait.frames(function() printToAll("Confirm All Commanders Are Seated") end, 8)

    NoImage.setPosition({3,1.2,-11})
    NoImage.setLock(true)
    YesImage.setPosition({-3,1.2,-11})
    YesImage.setLock(true)
    Wait.frames(function() NoImage.createButton(NoButton_parameters) end, 10)
    Wait.frames(function() YesImage.createButton(YesButton_parameters) end, 10)
end

---------------------Cancel Setup after N clicked

function GameSetupCancel()
    NoImage.setPosition({3,-1,-11})
    YesImage.setPosition({-3,-1,-11})
    StartGameImage.createButton(GameSetup_parameters)
end

---------------------Finish Setup after Y clicked

function GameSetup()
    GameStarted = 1
    YesImage.removeButton(0)
    NoImage.removeButton(0)
    destroyObject(StartGameImage)
    destroyObject(NoImage)
    destroyObject(YesImage)
    destroyObject(FirstEncounter)
    destroyObject(FirstEncounterToken)
    FirstEncounterBox.setPosition({-34,1,19.5})

    printToAll('Initializing')
    if FE == 1 then
        FirstEncounterShip_parameters = {}
        FirstEncounterShip_parameters.position = {-16.11,2,7.04}
        FirstEncounterShip_parameters.callback_function = function(obj) RotateAndFlip(obj) end
        FirstEncounterCrew_parameters = {}
        FirstEncounterCrew_parameters.position = {-16.11,2,11.96}
        FirstEncounterCrew_parameters.flip = true
        FirstEncounterCrew_parameters.callback_function = function(obj) RotateAndFlip(obj) end
        FirstEncounterContracts_parameters = {}
        FirstEncounterContracts_parameters.position = {22.81,2,7.44}
        FirstEncounterContracts_parameters.flip = true
        FirstEncounterContracts_parameters.callback_function = function(obj) RotateAndFlip(obj) end
        printToAll("..Including First Encounter Promotional Expansion..")
        FirstEncounterBox.takeObject(FirstEncounterShip_parameters)
        FirstEncounterBox.takeObject(FirstEncounterCrew_parameters)
        FirstEncounterBox.takeObject(FirstEncounterContracts_parameters)
        Wait.time(FEContracts, 2.5)
        Wait.time(IncludeHardExpansionContracts,6)
    end

    Wait.frames(function() printToAll("..") end, 2)
    Wait.frames(function() printToAll("...") end, 4)
    Wait.frames(function() printToAll("..") end, 6)
    ObjectivesDeck.shuffle()
    ObjectivesDeck.shuffle()
    ObjectivesDeck.shuffle()
    ContractsDeck.shuffle()
    ContractsDeck.shuffle()
    ContractsDeck.shuffle()
    CrewDeck.shuffle()
    CrewDeck.shuffle()
    CrewDeck.shuffle()
    ShipPartsDeck.shuffle()
    ShipPartsDeck.shuffle()
    ShipPartsDeck.shuffle()

---------------------Deal Cards and Set Ships

    SeatedPlayers = getSeatedPlayers()
    PlayerCount = #SeatedPlayers

    BlueDeal_parameters = {}
    BlueDeal_parameters.position = {-32,3,-18}
    BlueDeal_parameters.flip = true

    GreenDeal_parameters = {}
    GreenDeal_parameters.position = {-8,3,-18}
    GreenDeal_parameters.flip = true

    YellowDeal_parameters = {}
    YellowDeal_parameters.position = {16,3,-18}
    YellowDeal_parameters.flip = true

    PurpleDeal_parameters = {}
    PurpleDeal_parameters.position = {-36,3,10}
    PurpleDeal_parameters.rotation = {0,270,0}
    PurpleDeal_parameters.flip = true

    OrangeDeal_parameters = {}
    OrangeDeal_parameters.position = {36,3,-6}
    OrangeDeal_parameters.rotation = {0,90,0}
    OrangeDeal_parameters.flip = true

    if Player.Purple.seated == true then
        PFirstCredit_parameters = {}
        PFirstCredit_parameters.position = {-33.91,4,2.3}
        PSecondCredit_parameters = {}
        PSecondCredit_parameters.position = {-34.12,5,1.63}
        ReactorDeck.takeObject(PurpleDeal_parameters)
        ReactorDeck.takeObject(PurpleDeal_parameters)
        ReactorDeck.takeObject(PurpleDeal_parameters)
        ThrusterDeck.takeObject(PurpleDeal_parameters)
        ThrusterDeck.takeObject(PurpleDeal_parameters)
        ShieldDeck.takeObject(PurpleDeal_parameters)
        ShieldDeck.takeObject(PurpleDeal_parameters)
        Damage1Deck.takeObject(PurpleDeal_parameters)
        Damage1Deck.takeObject(PurpleDeal_parameters)
        MissDeck.takeObject(PurpleDeal_parameters)
        Wait.time(PurpleDeckShuffle,2)
        Wait.time(function() Credits1.takeObject(PFirstCredit_parameters) Credits1.takeObject(PSecondCredit_parameters) end, 1)
        Wait.time(function() PurpleShip.setPositionSmooth({4.89,5,11.79}) PurpleShip.setRotationSmooth({0,90,0}) end, 4) else
        Wait.time(function() PurpleShip.setPositionSmooth({-4,5,32}) PurpleShip.setRotationSmooth({0,180,0}) end, 4)
    end

    if Player.Blue.seated == true then
        BFirstCredit_parameters = {}
        BFirstCredit_parameters.position = {-24.5,4,-15.68}
        BSecondCredit_parameters = {}
        BSecondCredit_parameters.position = {-24.06,5,-15.81}
        ReactorDeck.takeObject(BlueDeal_parameters)
        ReactorDeck.takeObject(BlueDeal_parameters)
        ReactorDeck.takeObject(BlueDeal_parameters)
        ThrusterDeck.takeObject(BlueDeal_parameters)
        ThrusterDeck.takeObject(BlueDeal_parameters)
        ShieldDeck.takeObject(BlueDeal_parameters)
        ShieldDeck.takeObject(BlueDeal_parameters)
        Damage1Deck.takeObject(BlueDeal_parameters)
        Damage1Deck.takeObject(BlueDeal_parameters)
        MissDeck.takeObject(BlueDeal_parameters)
        Wait.time(BlueDeckShuffle,2)
        Wait.time(function() Credits1.takeObject(BFirstCredit_parameters) Credits1.takeObject(BSecondCredit_parameters) end, 1)
        Wait.time(function() BlueShip.setPositionSmooth({5.66,5,12.5}) BlueShip.setRotationSmooth({0,90,0}) end, 4.5) else
        Wait.time(function() BlueShip.setPositionSmooth({-2,5,32}) BlueShip.setRotationSmooth({0,180,0}) end, 4.5)
    end

    if Player.Green.seated == true then
        GFirstCredit_parameters = {}
        GFirstCredit_parameters.position = {-0.6,4,-15.68}
        GSecondCredit_parameters = {}
        GSecondCredit_parameters.position = {-0.15,5,-15.81}
        ReactorDeck.takeObject(GreenDeal_parameters)
        ReactorDeck.takeObject(GreenDeal_parameters)
        ReactorDeck.takeObject(GreenDeal_parameters)
        ThrusterDeck.takeObject(GreenDeal_parameters)
        ThrusterDeck.takeObject(GreenDeal_parameters)
        ShieldDeck.takeObject(GreenDeal_parameters)
        ShieldDeck.takeObject(GreenDeal_parameters)
        Damage1Deck.takeObject(GreenDeal_parameters)
        Damage1Deck.takeObject(GreenDeal_parameters)
        MissDeck.takeObject(GreenDeal_parameters)
        Wait.time(GreenDeckShuffle,2)
        Wait.time(function() Credits1.takeObject(GFirstCredit_parameters) Credits1.takeObject(GSecondCredit_parameters) end, 1)
        Wait.time(function() GreenShip.setPositionSmooth({6.42,5,13.15}) GreenShip.setRotationSmooth({0,90,0}) end, 5) else
        Wait.time(function() GreenShip.setPositionSmooth({0,5,32}) GreenShip.setRotationSmooth({0,180,0}) end, 5)
    end

    if Player.Yellow.seated == true then
        YFirstCredit_parameters = {}
        YFirstCredit_parameters.position = {24.5,4,-15.68}
        YSecondCredit_parameters = {}
        YSecondCredit_parameters.position = {24.06,5,-15.81}
        ReactorDeck.takeObject(YellowDeal_parameters)
        ReactorDeck.takeObject(YellowDeal_parameters)
        ReactorDeck.takeObject(YellowDeal_parameters)
        ThrusterDeck.takeObject(YellowDeal_parameters)
        ThrusterDeck.takeObject(YellowDeal_parameters)
        ShieldDeck.takeObject(YellowDeal_parameters)
        ShieldDeck.takeObject(YellowDeal_parameters)
        Damage1Deck.takeObject(YellowDeal_parameters)
        Damage1Deck.takeObject(YellowDeal_parameters)
        MissDeck.takeObject(YellowDeal_parameters)
        Wait.time(YellowDeckShuffle,2)
        Wait.time(function() Credits1.takeObject(YFirstCredit_parameters) Credits1.takeObject(YSecondCredit_parameters) end, 1)
        Wait.time(function() YellowShip.setPositionSmooth({4.89,5,13.15}) YellowShip.setRotationSmooth({0,90,0}) end, 5.5) else
        Wait.time(function() YellowShip.setPositionSmooth({2,5,32}) YellowShip.setRotationSmooth({0,180,0}) end, 5.5)
    end

    if Player.Orange.seated == true then
        OFirstCredit_parameters = {}
        OFirstCredit_parameters.position = {33.91,4,2.3}
        OSecondCredit_parameters = {}
        OSecondCredit_parameters.position = {34.12,5,1.63}
        ReactorDeck.takeObject(OrangeDeal_parameters)
        ReactorDeck.takeObject(OrangeDeal_parameters)
        ReactorDeck.takeObject(OrangeDeal_parameters)
        ThrusterDeck.takeObject(OrangeDeal_parameters)
        ThrusterDeck.takeObject(OrangeDeal_parameters)
        ShieldDeck.takeObject(OrangeDeal_parameters)
        ShieldDeck.takeObject(OrangeDeal_parameters)
        Damage1Deck.takeObject(OrangeDeal_parameters)
        Damage1Deck.takeObject(OrangeDeal_parameters)
        MissDeck.takeObject(OrangeDeal_parameters)
        Wait.time(OrangeDeckShuffle,2)
        Wait.time(function() Credits1.takeObject(OFirstCredit_parameters) Credits1.takeObject(OSecondCredit_parameters) end, 1)
        Wait.time(function() OrangeShip.setPositionSmooth({6.42,5,11.79}) OrangeShip.setRotationSmooth({0,90,0}) end, 6) else
        Wait.time(function() OrangeShip.setPositionSmooth({4,5,32}) OrangeShip.setRotationSmooth({0,180,0}) end, 6)
    end

---------------------Call other setup functions

    Wait.time(Objectives,1)
    Wait.time(ExtraContractShuffle,4)
    Wait.time(SetupContracts,5)
    Wait.time(ExtraContractShuffle,7)
    Wait.time(SetupCrew,2)
    Wait.time(SetupShipParts,3)
    Wait.time(FirstPlayer,7)
    Wait.time(Prophet, 180)
end
---------------------Other setup functions

function Prophet()
    printToAll("Inco..ng Tr...missi.n...")
    Wait.time(function() printToAll("..") end, 1)
    Wait.time(function() printToAll("...") end, 2)
    Wait.time(function() printToAll("..") end, 3)
    Wait.time(function() printToAll("E..d.n Spe..s, Who Wi.. .isten?") end, 5)
    Wait.time(function() printToAll("..") end, 6)
    Wait.time(function() printToAll("ww..e.te.th..em.le.com") end, 6)
    Wait.time(function() printToAll(".") end, 7)
    Wait.time(function() printToAll("...") end, 9)
    Wait.time(function() printToAll("Previous Message Truncated... Repeating Transmission...") end, 11)
    Wait.time(function() printToAll("...") end, 12)
    Wait.time(function() printToAll("..") end, 12.2)
    Wait.time(function() printToAll("...") end, 12.4)
    Wait.time(function() printToAll(".......") end, 12.6)
    Wait.time(function() printToAll(".............") end, 12.8)
    Wait.time(function() printToAll("www.enterthetemple.com") end, 15)
end

function RotateAndFlip(obj_spawned)
    obj_spawned.setRotation({0,180,0})
    obj_spawned.flip()
end

function FEContracts()
    FirstEncounterContracts = getObjectFromGUID(FirstEncounterContracts_GUID)
    FEContractEasy_parameters = {}
    FEContractEasy_parameters.position = {17.81,2,7.44}
    FirstEncounterContracts.takeObject(FEContractEasy_parameters)
    FirstEncounterContracts.takeObject(FEContractEasy_parameters)
end
----------------Objectives Setup

function Objectives()
    ObjectivesDeck.deal(3)
    printToAll(">>> Before Continuing, DISCARD ONE objective card, facedown. <<<")
    printToAll(">>> PLACE the TWO you wish to keep facedown on the table. <<<")
    Wait.time(function() printToAll("..") end, 1)
    Wait.time(function() printToAll("...") end, 2)
    Wait.time(function() printToAll("..") end, 3)
end

----------------Contracts Setup
function ExtraContractShuffle()
    ContractsDeck.shuffle()
    ContractsDeck.shuffle()
    ContractsDeck.shuffle()
end

function SetupContracts()
    ContractsDeck.shuffle()
    ContractsDeck.shuffle()
    ContractsDeck.shuffle()
    Contract1_parameters = {}
    Contract1_parameters.position = {5.59,1.18,9.29}
    Contract1_parameters.flip = true
    Contract2_parameters = {}
    Contract2_parameters.position = {8.47,1.18,9.29}
    Contract2_parameters.flip = true
    Contract3_parameters = {}
    Contract3_parameters.position = {11.32,1.18,9.29}
    Contract3_parameters.flip = true
    Contract4_parameters = {}
    Contract4_parameters.position = {14.16,1.18,9.29}
    Contract4_parameters.flip = true
    Contract5_parameters = {}
    Contract5_parameters.position = {5.59,1.18,5.5}
    Contract5_parameters.flip = true
    Contract6_parameters = {}
    Contract6_parameters.position = {8.47,1.18,5.5}
    Contract6_parameters.flip = true
    Contract7_parameters = {}
    Contract7_parameters.position = {11.32,1.18,5.5}
    Contract7_parameters.flip = true
    Contract8_parameters = {}
    Contract8_parameters.position = {14.16,1.18,5.5}
    Contract8_parameters.flip = true

    ContractsDeck.takeObject(Contract1_parameters)
    ContractsDeck.takeObject(Contract2_parameters)
    ContractsDeck.takeObject(Contract3_parameters)
    ContractsDeck.takeObject(Contract4_parameters)
    ContractsDeck.takeObject(Contract5_parameters)
    ContractsDeck.takeObject(Contract6_parameters)
    ContractsDeck.takeObject(Contract7_parameters)
    ContractsDeck.takeObject(Contract8_parameters)

    T2ContractsDeck.setLock(false)
    ContractsDeck = T2ContractsDeck
    Wait.time(function() ContractsDeck.shuffle() end, 1)
    Wait.time(function() ContractsDeck.shuffle() end, 1)
end

function IncludeHardExpansionContracts()
    FirstEncounterContracts.setPosition({17.81,2,7.44})
end

----------------Crew Setup

function SetupCrew()
    CrewDeck.shuffle()
    CrewDeck.shuffle()
    Crew1_parameters = {}
    Crew1_parameters.position = {-12.44,1.18,12.14}
    Crew1_parameters.flip = true
    Crew2_parameters = {}
    Crew2_parameters.position = {-9.55,1.18,12.14}
    Crew2_parameters.flip = true
    Crew3_parameters = {}
    Crew3_parameters.position = {-6.7,1.18,12.14}
    Crew3_parameters.flip = true

    CrewDeck.takeObject(Crew1_parameters)
    CrewDeck.takeObject(Crew2_parameters)
    CrewDeck.takeObject(Crew3_parameters)

end

----------------Ship Parts Setup

function SetupShipParts()
    ShipPartsDeck.shuffle()
    ShipPartsDeck.shuffle()

    ShipPart1_parameters = {}
    ShipPart1_parameters.position = {-12.43,1.18,8.47}
    ShipPart1_parameters.flip = true
    ShipPart2_parameters = {}
    ShipPart2_parameters.position = {-9.56,1.18,8.47}
    ShipPart2_parameters.flip = true
    ShipPart3_parameters = {}
    ShipPart3_parameters.position = {-6.71,1.18,8.47}
    ShipPart3_parameters.flip = true
    ShipPart4_parameters = {}
    ShipPart4_parameters.position = {-12.43,1.18,5.60}
    ShipPart4_parameters.flip = true
    ShipPart5_parameters = {}
    ShipPart5_parameters.position = {-9.56,1.18,5.60}
    ShipPart5_parameters.flip = true
    ShipPart6_parameters = {}
    ShipPart6_parameters.position = {-6.71,1.18,5.60}
    ShipPart6_parameters.flip = true

    ShipPartsDeck.takeObject(ShipPart1_parameters)
    ShipPartsDeck.takeObject(ShipPart2_parameters)
    ShipPartsDeck.takeObject(ShipPart3_parameters)
    ShipPartsDeck.takeObject(ShipPart4_parameters)
    ShipPartsDeck.takeObject(ShipPart5_parameters)
    ShipPartsDeck.takeObject(ShipPart6_parameters)
end

---------------------Get and Shuffle Decks
function PurpleDeckShuffle()
    PurpleDeck = GetPurpleDeck()
    PurpleDeck.shuffle()
    PurpleDeck.shuffle()
end

function BlueDeckShuffle()
    BlueDeck = GetBlueDeck()
    BlueDeck.shuffle()
    BlueDeck.shuffle()
end

function GreenDeckShuffle()
    GreenDeck = GetGreenDeck()
    GreenDeck.shuffle()
    GreenDeck.shuffle()
end

function YellowDeckShuffle()
    YellowDeck = GetYellowDeck()
    YellowDeck.shuffle()
    YellowDeck.shuffle()
end

function OrangeDeckShuffle()
    OrangeDeck = GetOrangeDeck()
    OrangeDeck.shuffle()
    OrangeDeck.shuffle()
end

function GetPurpleDeck()
    if PurpleDeckZone ~= nil then
        for _, obj in ipairs(PurpleDeckZone.getObjects())
        do
            if obj.tag == "Deck" then
                return obj
            end
        end
    end
    return obj
end

function GetBlueDeck()
    if BlueDeckZone ~= nil then
        for _, obj in ipairs(BlueDeckZone.getObjects())
        do
            if obj.tag == "Deck" then
                return obj
            end
        end
    end
    return obj
end

function GetGreenDeck()
    if GreenDeckZone ~= nil then
        for _, obj in ipairs(GreenDeckZone.getObjects())
        do
            if obj.tag == "Deck" then
                return obj
            end
        end
    end
    return obj
end
function GetYellowDeck()
    if YellowDeckZone ~= nil then
        for _, obj in ipairs(YellowDeckZone.getObjects())
        do
            if obj.tag == "Deck" then
                return obj
            end
        end
    end
    return obj
end
function GetOrangeDeck()
    if OrangeDeckZone ~= nil then
        for _, obj in ipairs(OrangeDeckZone.getObjects())
        do
            if obj.tag == "Deck" then
                return obj
            end
        end
    end
    return obj
end

---------------------Random First Player Determination

function FirstPlayer()
    Player1 = SeatedPlayers[1]
    Player2 = SeatedPlayers[2]
    Player3 = SeatedPlayers[3]
    Player4 = SeatedPlayers[4]
    Player5 = SeatedPlayers[5]
    FirstTurn = math.random(1, #SeatedPlayers)
    if FirstTurn == 1 then
        FirstTurnColor = Player1
        Turns.turn_color = Player1 else
            if FirstTurn == 2 then
                FirstTurnColor = Player2
                Turns.turn_color = Player2 else
                    if FirstTurn == 3 then
                        FirstTurnColor = Player3
                        Turns.turn_color = Player3 else
                            if FirstTurn == 4 then
                                FirstTurnColor = Player4
                                Turns.turn_color = Player4 else
                                    if FirstTurn == 5 then
                                        FirstTurnColor = Player5
                                        Turns.turn_color = Player5 end
                                    end
                            end
                    end
            end
            FirstTurnColorString = FirstTurnColor
            printToAll("---> ".. FirstTurnColor .." Commander acts first.")
            Wait.frames(function() printToAll("..") end, 2)
            Wait.frames(function() printToAll("...") end, 4)
            Wait.frames(function() printToAll("..") end, 6)
            Wait.frames(function() printToAll("Remember the Cleanse.") end, 10)

    end

---------------------Other Functions

function onObjectEnterScriptingZone(zone, enter_object)
    if zone == ActiveContractZone and enter_object ~= nil and enter_object.tag == "Card" and enter_object.getDescription() == "Contract" then
        enter_object.setScale({2,2,2})
    end
end

function onObjectLeaveScriptingZone(zone, leave_object)
    if zone == ActiveContractZone and leave_object ~= nil and leave_object.tag == "Card" and leave_object.getDescription() == "Contract" then
        leave_object.setScale({1,1,1})
    end
end

--[[ The onUpdate event is called once per frame. --]]
function onUpdate()
    --[[ print('onUpdate loop!') --]]
end
