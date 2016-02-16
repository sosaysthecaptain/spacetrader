//
//  Alerts.swift
//  SpaceTrader
//
//  Created by Marc Auger on 2/4/16.
//  Copyright © 2016 Marc Auger. All rights reserved.
//

import Foundation

class Alert {
    let ID: AlertID
    let passedString1: String?
    let passedString2: String?
    let passedString3: String?
    let header: String
    let text: String
    let yesButton: String
    let noButton: String?
    var yesIsDestructive: Bool = false
    
    init(ID: AlertID, passedString1: String?, passedString2: String?, passedString3: String?) {
        self.ID = ID
        self.passedString1 = passedString1
        self.passedString2 = passedString2
        self.passedString3 = passedString3
        
        switch ID {
        case .AntidoteOnBoard:
            self.header = "Antidote"
            self.text = "Ten of your cargo bays now contain antidote for the Japori system."
            self.yesButton = "OK"
            self.noButton = nil
        case .AntidoteDestroyed:
            self.header = "Antidote Destroyed"
            self.text = "The antidote for the Japori system has been destroyed with your ship. You should return to ^1 and get some more."
            self.yesButton = "OK"
            self.noButton = nil
        case .AntidoteTaken:
            self.header = "Antidote Taken"
            self.text = "The Space Corps removed the antidote for Japori from your ship and delivered it, fulfilling your assignment."
            self.yesButton = "OK"
            self.noButton = nil
        case .ArrivalBuyNewspaper:
            self.header = "Buy Newspaper?"
            self.text = "The local newspaper costs ^1. Do you wish to buy a copy?"
            self.yesButton = "Buy Newspaper"
            self.noButton = "Cancel"
        case .ArrivalIFFuel:
            self.header = "No Full Tanks"
            self.text = "You do not have enough money to buy full tanks."
            self.yesButton = "OK"
            self.noButton = nil
        case .ArrivalIFFuelRepairs:
            self.header = "Not Enough Money"
            self.text = "You don't have enough money to get a full tank or full hull repairs."
            self.yesButton = "OK"
            self.noButton = nil
        case .ArrivalIFNewspaper:
            self.header = "Can't Afford it!"
            self.text = "Sorry! A newspaper costs \(self.passedString1) cr. in this system. You don't have enough money!"
            self.yesButton = "OK"
            self.noButton = nil
        case .ArrivalIFRepairs:
            self.header = "No Full Repairs"
            self.text = "You don't have enough money to get your hull fully repaired."
            self.yesButton = "OK"
            self.noButton = nil
        case .ArtifactLost:
            self.header = "Artifact Lost"
            self.text = "The alien artifact has been lost in the wreckage of your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .ArtifactOnBoard:
            self.header = "Artifact On Board"
            self.text = "The artifact is now in your cargo hold."
            self.yesButton = "OK"
            self.noButton = nil
        case .ArtifactRelinquished:
            self.header = "Artifact Relinquished"
            self.text = "The aliens take the artifact from you."
            self.yesButton = "OK"
            self.noButton = nil
        case .CargoIF:
            self.header = "Not Enough Money"
            self.text = "You don't have enough money to spend on any of these goods."
            self.yesButton = "OK"
            self.noButton = nil
        case .CargoNoEmptyBays:
            self.header = "No Empty Bays"
            self.text = "You don't have any empty cargo holds available at the moment."
            self.yesButton = "OK"
            self.noButton = nil
        case .CargoNoneAvailable:
            self.header = "Nothing Available"
            self.text = "None of these goods are available."
            self.yesButton = "OK"
            self.noButton = nil
        case .CargoNoneToSell:
            self.header = "No \(self.passedString1) To Sell"
            self.text = "You have none of these goods in your cargo bays."
            self.yesButton = "OK"
            self.noButton = nil
        case .CargoNotInterested:
            self.header = "Not Interested"
            self.text = "Nobody in this system is interested in buying these goods."
            self.yesButton = "OK"
            self.noButton = nil
        case .CargoNotSold:
            self.header = "Not Available"
            self.text = "That item is not available in this system."
            self.yesButton = "OK"
            self.noButton = nil
        case .ChartJump:
            self.header = "Use Singularity?"
            self.text = "Do you wish to use the Portable Singularity to transport immediately to \(self.passedString1)?"
            self.yesButton = "Use Singularity"
            self.noButton = "Don't use it"
            self.yesIsDestructive = true
        case .ChartJumpCurrent:
            self.header = "Cannot Jump"
            self.text = "You are tracking the system where you are currently located. It's useless to jump to your current location."
            self.yesButton = "OK"
            self.noButton = nil
        case .ChartJumpNoSystemSelected:
            self.header = "No System Selected"
            self.text = "To use the Portable Singularity, track a system before clicking on this button."
            self.yesButton = "OK"
            self.noButton = nil
        case .ChartTrackSystem:
            self.header = "Track System?"
            self.text = "Track \(self.passedString1)?"
            self.yesButton = "Yes"
            self.noButton = "No"
        case .ChartWormholeUnreachable:
            self.header = "Wormhole Unreachable"
            self.text = "The wormhole to \(self.passedString1) is only accessible from \(self.passedString2)."
            self.yesButton = "OK"
            self.noButton = nil
        case .Cheater:
            self.header = "Cheater!"
            self.text = "Cheaters never prosper!  (Well, not with that command, anyway.)"
            self.yesButton = "OK"
            self.noButton = nil
        case .CrewFireMercenary:
            self.header = "Fire Mercenary?"
            self.text = "Are you sure you wish to fire \(self.passedString1)?"
            self.yesButton = "Yes"
            self.noButton = "No"
        case .CrewNoQuarters:
            self.header = "No Quarters Available"
            self.text = "You do not have any crew quarters available for \(self.passedString1)."
            self.yesButton = "OK"
            self.noButton = nil
        case .DebtNoBuy:
            self.header = "You Have a Debt"
            self.text = "You can't buy that as long as you have debts."
            self.yesButton = "OK"
            self.noButton = nil
        case .DebtNone:
            self.header = "No Debt"
            self.text = "You have no debts."
            self.yesButton = "OK"
            self.noButton = nil
        case .DebtReminder:
            self.header = "Loan Notification"
            self.text = "The Bank's Loan Officer reminds you that your debt continues to accrue interest. You currently owe \(self.passedString1)."
            self.yesButton = "OK"
            self.noButton = nil
        case .DebtTooLargeGrounded:
            self.header = "Large Debt"
            self.text = "Your debt is too large.  You are not allowed to leave this system until your debt is lowered."
            self.yesButton = "OK"
            self.noButton = nil
        case .DebtTooLargeLoan:
            self.header = "Debt Too High"
            self.text = "Your debt is too high to get another loan."
            self.yesButton = "OK"
            self.noButton = nil
        case .DebtTooLargeTrade:
            self.header = "Large Debt"
            self.text = "Your debt is too large. Nobody will trade with you."
            self.yesButton = "OK"
            self.noButton = nil
        case .DebtWarning:
            self.header = "Warning: Large Debt"
            self.text = "Your debt is getting too large. Reduce it quickly or your ship will be pit on a chain!"
            self.yesButton = "OK"
            self.noButton = nil
        case .Egg:
            self.header = "Egg"
            self.text = "Congratulations! An eccentric Easter Bunny decides to exchange your trade goods for a special present!"
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterAliensSurrender:
            self.header = "Surrender"
            self.text = "If you surrender to the aliens, they will take the artifact. Are you sure you wish to do that?"
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterArrested:
            self.header = "Arrested"
            self.text = "You are arrested and taken to the space station, where you are brought before a court of law."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterAttackCaptain:
            self.header = "Really Attack?"
            self.text = "Famous Captains get famous by, among other things, destroying everyone who attacks them. Do you really want to attack?"
            self.yesButton = "Really Attack"
            self.noButton = "OK, I Won't"
            self.yesIsDestructive = true
        case .EncounterAttackNoDisruptors:
            self.header = "No Disabling Weapons"
            self.text = "You have no disabling weapons! You would only be able to destroy your opponent, which would defeat the purpose of your quest."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterAttackNoLasers:
            self.header = "No Hull-Damaging Weapons"
            self.text = "You only have disabling weapons, but your opponent cannot be disabled!"
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterAttackNoWeapons:
            self.header = "No Weapons"
            self.text = "You can't attack without weapons!"
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterAttackPolice:
            self.header = "Attack Police"
            self.text = "Are you sure you wish to attack the police? This will turn you into a criminal!"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .EncounterAttackTrader:
            self.header = "Attack Trader"
            self.text = "Are you sure you wish to attack the trader? This will immediately set your police record to dubious!"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .EncounterBothDestoryed:
            self.header = "Both Destroyed"
            self.text = "You and your opponent have managed to destroy each other."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterDisabledOpponent:
            self.header = "Opponent Disabled"
            self.text = "You have disabled your opponent. Without life support they'll have to hibernate. You notify Space Corps, and they come and tow the \(self.passedString1) to the planet \(self.passedString2), where the crew is revived and then arrested."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterDrinkContents:
            self.header = "Drink Contents?"
            self.text = "You have come across an extremely rare bottle of Captain Marmoset's Amazing Skill Tonic! The \"use-by\" date is illegible, but might still be good.  Would you like to drink it?"
            self.yesButton = "Yes, Drink It"
            self.noButton = "No"
        case .EncounterDumpAll:
            self.header = "Dump All?"
            self.text = "You paid \(self.passedString1) credits for these items. Are you sure you want to just dump them?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .EncounterDumpWarning:
            self.header = "Space Littering"
            self.text = "Dumping cargo in space is considered littering. If the police find your dumped goods and track them to you, this will influence your record. Do you really wish to dump?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .EncounterEscaped:
            self.header = "Escaped"
            self.text = "You have managed to escape your opponent."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterEscapeHit:
            self.header = "You Escaped"
            self.text = "You got hit, but still managed to escape."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterEscapePodActivated:
            self.header = "Escape Pod Activated"
            self.text = "ust before the final demise of your ship, your escape pod gets activated and ejects you. After a few days, the Space Corps picks you up and drops you off at a nearby space port."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterLooting:
            self.header = "Looting"
            self.text = "The pirates board your ship and transfer as much of your cargo to their own ship as their cargo bays can hold."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterMarieCeleste:
            self.header = "Engage Marie Celeste"
            self.text = "The ship is empty: there is nothing in the ship's log, but the crew has vanished, leaving food on the tables and cargo in the holds. Do you wish to offload the cargo to your own holds?"
            self.yesButton = "Yes"
            self.noButton = "No"
        case .EncounterMarieCelesteNoBribe:
            self.header = "No Bribe"
            self.text = "We'd love to take your money, but Space Command already knows you've got illegal goods onboard."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterOpponentEscaped:
            self.header = "Opponent Escaped"
            self.text = "Your opponent has managed to escape."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPiratesBounty:
            self.header = "Bounty"
            self.text = "You \(self.passedString1) the pirate ship and earned a bounty of \(self.passedString2) cr."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPiratesExamineReactor:
            self.header = "Pirates Examine Reactor"
            self.text = "The pirates poke around the Ion Reactor while trying to figure out if it's valuable. They finally conclude that the Reactor is worthless, not to mention dangerous, and leave it on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPiratesFindNoCargo:
            self.header = "Pirates Find No Cargo"
            self.text = "The pirates are very angry that they find no cargo on your ship. To stop them from destroying you, you have no choice but to pay them an amount equal to 5% of your current worth \(self.passedString1)."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPiratesSurrenderPrincess:
            self.header = "You Have The Princess"
            self.text = "Pirates are not nice people, and there's no telling what they might do to the Princess. Better to die fighting than give her up to them!"
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPiratesTakeSculpture:
            self.header = "Pirates Take Sculpture"
            self.text = "As the pirates ransack your ship, they find the stolen sculpture. \"This is worth thousands!\" one pirate exclaims, as he stuffs it into his pack."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPoliceBribe:
            self.header = "Bribe"
            self.text = "These police officers are willing to forego inspection for the amount of \(self.passedString1)."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPoliceBribeCant:
            self.header = "No Bribe"
            self.text = "These police officers can't be bribed."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPoliceBribeLowCash:
            self.header = "Not Enough Cash"
            self.text = "You don't have enough cash for a bribe."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPoliceFine:
            self.header = "Caught"
            self.text = "The police discover illegal goods in your cargo holds. These goods are impounded and you are fined \(self.passedString1) credits."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPoliceNothingFound:
            self.header = "Nothing Found"
            self.text = "The police find nothing illegal in your cargo holds, and apologize for the inconvenience."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPoliceNothingIllegal:
            self.header = "You Have Nothing Illegal"
            self.text = "Are you sure you want to do that? You are not carrying illegal goods, so you have nothing to fear!"
            self.yesButton = "Yes, I still want to"
            self.noButton = "OK, I Won't"
            self.yesIsDestructive = true
        case .EncounterPoliceSubmit:
            self.header = "You Have Illegal Goods"
            self.text = "Are you sure you want to let the police search you? You are carrying \(self.passedString1)!"
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPoliceSurrender:
            self.header = "Surrender"
            self.text = "If you surrender, you will spend some time in prison and will have to pay a hefty fine. Are you sure you want to do that?"
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPostMarie:
            self.header = "Contraband Removed"
            self.text = "The Customs Police confiscated all of your illegal cargo, but since you were cooperative, you avoided stronger fines or penalties."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterPostMarieFlee:
            self.header = "Criminal Act!"
            self.text = "Are you sure you want to do that? The Customs Police know you have engaged in criminal activity, and will report it!"
            self.yesButton = "Yes, I still want to"
            self.noButton = "OK, I won't"
        case .EncounterScoop:
            self.header = "Scoop Canister"
            self.text = "A canister from the destroyed ship, labeled \(self.passedString1), drifts within range of your scoops."
            self.yesButton = "Pick It Up"
            self.noButton = "Let It Go"
        case .EncounterScoopNoRoom:
            self.header = "No Room To Scoop"
            self.text = "You don't have any room in your cargo holds. Do you wish to jettison goods to make room, or just let it go?"
            self.yesButton = "Make Room"
            self.noButton = "Let It Go"
        case .EncounterScoopNoScoop:
            self.header = "No Scoop"
            self.text = "You regret finding nothing in your holds that can be dumped, and let the canister go."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterSurrenderRefused:
            self.header = "To The Death!"
            self.text = "Surrender? Hah! We want your HEAD!"
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterTonicConsumedGood:
            self.header = "Tonic Consumed"
            self.text = "Mmmmm. Captain Marmoset's Amazing Skill Tonic not only fills you with energy, but tastes like a fine single-malt."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterTonicConsumedStrange:
            self.header = "Tonic Consumed"
            self.text = "While you don't know what it was supposed to taste like, you get the feeling that this dose of tonic was a bit off."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterTradeCompleted:
            self.header = "Trade Completed"
            self.text = "Thanks for the \(self.passedString1). It's been a pleasure doing business with you."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterYouLose:
            self.header = "You Lose"
            self.text = "Your ship has been destroyed by your opponent."
            self.yesButton = "OK"
            self.noButton = nil
        case .EncounterYouWin:
            self.header = "You Win"
            self.text = "You have destroyed your opponent."
            self.yesButton = "OK"
            self.noButton = nil
        case .EquipmentAlreadyOwn:
            self.header = "You Already Have One"
            self.text = "It's not useful to buy more than one of this item."
            self.yesButton = "OK"
            self.noButton = nil
        case .EquipmentBuy:
            self.header = "Buy \(self.passedString1)?"
            self.text = "Do you wish to buy this item for \(self.passedString1) credits?"
            self.yesButton = "Yes"
            self.noButton = "No"
        case .EquipmentEscapePod:
            self.header = "Escape Pod"
            self.text = "Do you want to buy an escape pod for 2,000 credits?"
            self.yesButton = "Yes"
            self.noButton = "No"
        case .EquipmentExtraBaysInUse:
            self.header = "Cargo Bays Full"
            self.text = "The extra cargo bays are still filled with goods. You can only sell them when they're empty."
            self.yesButton = "OK"
            self.noButton = nil
        case .EquipmentFuelCompactor:
            self.header = "Fuel Compactor"
            self.text = "You now have a fuel compactor installed on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .EquipmentHiddenCompartments:
            self.header = "Hidden Compartments"
            self.text = "You now have hidden compartments equivalent to 5 extra cargo bays installed in your ship. Police won't find illegal cargo hidden in these compartments."
            self.yesButton = "OK"
            self.noButton = nil
        case .EquipmentIF:
            self.header = "Not Enough Money"
            self.text = "You don't have enough money to spend on this item."
            self.yesButton = "OK"
            self.noButton = nil
        case .EquipmentLightningShield:
            self.header = "Lightning Shield"
            self.text = "You now have one lightning shield installed on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .EquipmentMorgansLaser:
            self.header = "Morgan's Laser"
            self.text = "You now have Henry Morgans special laser installed on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .EquipmentNotEnoughSlots:
            self.header = "Not Enough Slots"
            self.text = "You have already filled all of your available slots for this type of item."
            self.yesButton = "OK"
            self.noButton = nil
        case .EquipmentQuantumDisruptor:
            self.header = "Quantum Disruptor"
            self.text = "You now have one quantum disruptor installed on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .EquipmentSell:
            self.header = "Sell Item"
            self.text = "Are you sure you want to sell this item?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .FleaBuilt:
            self.header = "Flea Built"
            self.text = "In 3 days and with 500 credits, you manage to convert your pod into a Flea."
            self.yesButton = "OK"
            self.noButton = nil
        case .GameAbandonConfirm:
            self.header = "Are You Sure?"
            self.text = "Are you sure you want to abandon your current game?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .GameClearHighScores:
            self.header = "Clear High Scores?"
            self.text = "Are you sure you wish to clear the high score table?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .GameEndBoughtMoon:
            self.header = "Retirement"
            self.text = "You have retired to your own moon."
            self.yesButton = "OK"
            self.noButton = nil
        case .GameEndBoughtMoonGirl:
            self.header = "Retirement"
            self.text = "You have retired with the Princess."
            self.yesButton = "OK"
            self.noButton = nil
        case .GameEndHighScoreAchieved:
            self.header = "Congratulations!"
            self.text = "You have made the high-score list!"
            self.yesButton = "OK"
            self.noButton = nil
        case .GameEndHighScoreCheat:
            self.header = "Naughty, Naughty!"
            self.text = "You would have made the high-score list if you weren't a Cheat!"
            self.yesButton = "OK"
            self.noButton = nil
        case .GameEndHighScoreMissed:
            self.header = "Sorry"
            self.text = "Alas! This is not enough to enter the high-score list."
            self.yesButton = "OK"
            self.noButton = nil
        case .GameEndKilled:
            self.header = "Game Over"
            self.text = "You are dead."
            self.yesButton = "OK"
            self.noButton = nil
        case .GameEndRetired:
            self.header = "Retirement"
            self.text = "You retire to a remote, volcanic planet."
            self.yesButton = "OK"
            self.noButton = nil
        case .GameEndScore:
            self.header = "Score"
            self.text = "You achieved a score of \(self.passedString1)."
            self.yesButton = "OK"
            self.noButton = nil
        case .GameRetire:
            self.header = "Retire?"
            self.text = "Are you sure you wish to retire?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .HagglingComputer:
            self.header = "Haggling Computer"
            self.text = "You now have a handheld haggling computer. It takes up very little space, and will boost your effective trading skills."
            self.yesButton = "OK"
            self.noButton = nil
        case .InsuranceNoEscapePod:
            self.header = "No Escape Pod"
            self.text = "Insurance isn't useful for you, since you don't have an escape pod."
            self.yesButton = "OK"
            self.noButton = nil
        case .InsurancePayoff:
            self.header = "Insurance"
            self.text = "Since your ship was insured, the bank pays you the total worth of your destroyed ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .InsuranceStop:
            self.header = "Stop Insurance"
            self.text = "Do you really wish to stop your insurance and lose your no-claim?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .JailConvicted:
            self.header = "Convicted"
            self.text = "You are convicted and sentenced to \(self.passedString1) days in prison and a fine of \(self.passedString2) credits."
            self.yesButton = "OK"
            self.noButton = nil
        case .JailFleaReceived:
            self.header = "Flea Received"
            self.text = "When you leave prison, the police have left a second-hand Flea for you so you can continue your travels."
            self.yesButton = "OK"
            self.noButton = nil
        case .JailHiddenCargoBaysRemoved:
            self.header = "Hidden Compartments Removed"
            self.text = "When your ship is impounded, the police go over it with a fine-toothed comb. You hidden compartments are found and removed."
            self.yesButton = "OK"
            self.noButton = nil
        case .JailIllegalGoodsImpounded:
            self.header = "Illegal Goods Impounded"
            self.text = "The police also impound all of the illegal goods you have on board."
            self.yesButton = "OK"
            self.noButton = nil
        case .JailInsuranceLost:
            self.header = "Insurance Lost"
            self.text = "Since you cannot pay your insurance while you're in prison, it is retracted."
            self.yesButton = "OK"
            self.noButton = nil
        case .JailMercenariesLeave:
            self.header = "Mercenaries Leave"
            self.text = "Any mercenaries who were traveling with you have left."
            self.yesButton = "OK"
            self.noButton = nil
        case .JailShipSold:
            self.header = "Ship Sold"
            self.text = "Because you don't have the credits to pay your fine, your ship is sold."
            self.yesButton = "OK"
            self.noButton = nil
        case .JarekOnBoard:
            self.header = "Jarek On Board"
            self.text = "Ambassador Jarek boards your ship. While on board he will help out, but if you take too long getting him home he may become frustrated and stop helping."
            self.yesButton = "OK"
            self.noButton = nil
        case .JarekTakenHome:
            self.header = "Jarek Taken Home"
            self.text = "The Space Corps decides to give ambassador Jarek a lift home to Devidia."
            self.yesButton = "OK"
            self.noButton = nil
        case .LeavingIFInsurance:
            self.header = "Not Enough Money"
            self.text = "You don't have enough cash to pay for your insurance."
            self.yesButton = "OK"
            self.noButton = nil
        case .LeavingIFMercenaries:
            self.header = "Pay Mercenaries"
            self.text = "You don't have enough cash to pay your mercenaries to come with you on this trip. Fire them or make sure you have enough cash."
            self.yesButton = "OK"
            self.noButton = nil
        case .LeavingIFWormholeTax:
            self.header = "Wormhole Tax"
            self.text = "You don't have enough money to pay for the wormhole tax."
            self.yesButton = "OK"
            self.noButton = nil
        case .MeetCaptainAhab:
            self.header = "Meet Captain Ahab"
            self.text = "Captain Ahab is in need of a spare shield for an upcoming mission. He offers to trade you some piloting lessons for your reflective shield. Do you wish to trade?"
            self.yesButton = "Yes, Trade Shield"
            self.noButton = "No"
        case .MeetCaptainConrad:
            self.header = "Meet Captain Conrad"
            self.text = "Captain Conrad is in need of a military laser. She offers to trade you some engineering training for your military laser. Do you wish to trade?"
            self.yesButton = "Yes, Trade Laser"
            self.noButton = "No"
        case .MeetCaptainHuie:
            self.header = "Meet Captain Huie"
            self.text = "Captain Huie is in need of a military laser. She offers to exchange some bargaining training for your military laser. Do you wish to trade?"
            self.yesButton = "Yes, Trade Laser"
            self.noButton = "No"
        case .NewGameConfirm:
            self.header = "New Game"
            self.text = "Are you sure you wish to start an new game?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .NewGameMoreSkillPoints:
            self.header = "More Skill Points"
            self.text = "You haven't awarded all 20 skill points yet."
            self.yesButton = "OK"
            self.noButton = nil
        case .PreciousHidden:
            self.header = "Precious Cargo Hidden"
            self.text = "You quickly hide \(self.passedString1) in your hidden cargo bays before the pirates board your ship. This would never work with the police, but pirates are usually in more of a hurry."
            self.yesButton = "OK"
            self.noButton = nil
        case .PrincessComesAboard:
            self.header = "Princess Comes Aboard"
            self.text = "Princess Ziyal comes aboard your ship. She'll help out en route, but if you take too long to get her home she may become annoyed and stop helping."
            self.yesButton = "OK"
            self.noButton = nil
        case .PrincessTakenHome:
            self.header = "Princess Taken Home"
            self.text = "The Space Corps decides to give the Princess a ride home to Galvon since you obviously weren't up to the task."
            self.yesButton = "OK"
            self.noButton = nil
        case .ReactorConfiscated:
            self.header = "Police Confiscate Reactor"
            self.text = "The Police confiscate the Ion reactor as evidence of your dealings with unsavory characters."
            self.yesButton = "OK"
            self.noButton = nil
        case .ReactorDestroyed:
            self.header = "Reactor Destroyed"
            self.text = "The destruction of your ship was made much more spectacular by the added explosion of the Ion Reactor."
            self.yesButton = "OK"
            self.noButton = nil
        case .ReactorOnBoard:
            self.header = "Reactor"
            self.text = "Five of your cargo bays now contain the unstable Ion Reactor, and ten of your bays contain enriched fuel."
            self.yesButton = "OK"
            self.noButton = nil
        case .ReactorMeltdown:
            self.header = "Reactor Meltdown!"
            self.text = "Just as you approach the docking bay, the reactor explodes into a huge radioactive fireball!"
            self.yesButton = "OK"
            self.noButton = nil
        case .ReactorWarningFuel:
            self.header = "Reactor Warning"
            self.text = "You notice the Ion Reactor has begun to consume fuel rapidly. In a single day, it has burned up nearly half a bay of fuel!"
            self.yesButton = "OK"
            self.noButton = nil
        case .ReactorWarningFuelGone:
            self.header = "Reactor Warning"
            self.text = "The Ion Reactor is emitting a shrill whine, and it's shaking. The display indicates that it is suffering from fuel starvation."
            self.yesButton = "OK"
            self.noButton = nil
        case .ReactorWarningTemp:
            self.header = "Reactor Warning"
            self.text = "The Ion Reactor is smoking and making loud noises. The display warns that the core is close to the melting temperature."
            self.yesButton = "OK"
            self.noButton = nil
        case .SculptureConfiscated:
            self.header = "Police Confiscate Sculpture"
            self.text = "The Police confiscate the stolen sculpture and return it to its rightful owner."
            self.yesButton = "OK"
            self.noButton = nil
        case .SculptureSaved:
            self.header = "Sculpture Saved"
            self.text = "On your way to the escape pod, you grab the stolen sculpture. Oh well, at least you saved something."
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipBuyConfirm:
            self.header = "Buy New Ship"
            self.text = "Are you sure you wish to trade in your \(self.passedString1) for a new \(self.passedString2)?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .ShipBuyCrewQuarters:
            self.header = "Too Many Crewmwmbers"
            self.text = "The new ship you picked doesn't have enough quarters for all of your crewmembers. First you will have to fire one or more of them."
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipBuyIF:
            self.header = "Not Enough Money"
            self.text = "You don't have enough money to buy this ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipBuyIFTransfer:
            self.header = "Not Enough Money"
            self.text = "You won't have enough money to buy this ship and pay the cost to transfer all of your unique equipment. You should choose carefully which items you wish to transfer!"
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipBuyNoSlots:
            self.header = "Can't Transfer Item"
            self.text = "If you trade your ship in for a \(self.passedString1), you won't be able to transfer your \(self.passedString2) because the new ship has insufficient \(self.passedString3) slots!"
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipBuyNotAvailable:
            self.header = "Ship Not Available"
            self.text = "That type of ship is not available in the current system."
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipBuyNoTransfer:
            self.header = "Can't Transfer Item"
            self.text = "Unfortunately, if you make this trade, you won't be able to afford to transfer your \(self.passedString1) to the new ship!"
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipBuyPassengerQuarters:
            self.header = "Passenger Needs Quarters"
            self.text = "You must get a ship with enough crew quarters so that \(self.passedString1) can stay on board."
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipBuyReactor:
            self.header = "Shipyard Engineer"
            self.text = "Sorry! We can't take your ship as a trade-in. That Ion Reactor looks dangerous, and we have no way of removing it. Come back when you've gotten rid of it."
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipBuyTransfer:
            self.header = "Transfer \(self.passedString1)"
            self.text = "I'll transfer your \(self.passedString2) to your new ship for \(self.passedString3) credits."
            self.yesButton = "Do it!"
            self.noButton = "No thanks"
        case .ShipDesignIF:
            self.header = "Not Enough Money"
            self.text = "You don't have enough money to create this design."
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipDesignThanks:
            self.header = "Thank you!"
            self.text = "\(self.passedString1) thanks you for your business!"
            self.yesButton = "OK"
            self.noButton = nil
        case .ShipHullUpgraded:
            self.header = "Hull Upgraded"
            self.text = "Technicians spend the day retrofitting the hull of your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialCleanRecord:
            self.header = "Clean Record"
            self.text = "The hacker resets your police record to Clean."
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialExperimentPerformed:
            self.header = "Experiment Performed"
            self.text = "The galaxy is abuzz with news of a terrible malfunction in Dr. Fehler's laboratory. Evidently, he was not warned in time and he performed his experiment... with disastrous results!"
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialIF:
            self.header = "Not Enough Money"
            self.text = "You don't have enough cash to spend to accept this offer."
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialMoonBought:
            self.header = "Moon Bought"
            self.text = "You bought a moon in the Utopia system. Go there to claim it."
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialNoQuarters:
            self.header = "No Free Quarters"
            self.text = "There are currently no free crew quarters on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialNotEnoughBays:
            self.header = "Not Enough Bays"
            self.text = "You don't have enough empty cargo bays at the moment."
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialPassengerConcernedJarek:
            self.header = "Ship's Comm"
            self.text = "Commander? Jarek here. Do you require any assitance in charting a course to Devidia?"
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialPassengerConcernedPrincess:
            self.header = "Ship's Comm"
            self.text = "[Ziyal] Oh Captain? (giggles) Would it help if I got out and pushed?"
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialPassengerConcernedWild:
            self.header = "Ship's Comm"
            self.text = "Bridge? This is Jonathan. Are we there yet? Heh, heh. Sorry, I couldn't resist."
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialPassengerImpatientJarek:
            self.header = "Ship's Comm"
            self.text = "Captain! This is the Ambassador speaking. We should have been there by now?!"
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialPassengerImpatientPrincess:
            self.header = "Ship's Comm"
            self.text = "Sir! Are you taking me home or merely taking the place of my previous captors?!"
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialPassengerImpatientWild:
            self.header = "Ship's Comm"
            self.text = "Commander! Wild here. What's taking us so long?!"
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialPassengerOnBoard:
            self.header = "Passenger On Board"
            self.text = "You have taken \(self.passedString1) on board. While on board \(self.passedString1) will lend you expertise, but may stop helping if the journey takes too long."
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialSealedCanisters:
            self.header = "Sealed Canisters"
            self.text = "You bought the sealed canisters and put them in your cargo bays."
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialSkillIncrease:
            self.header = "Skill Increase"
            self.text = "The alien increases one of your skills."
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialSpacetimeFabricRip:
            self.header = "Spacetime Fabric Rip"
            self.text = "You have flown through a tear in the spacetime continuum caused by Dr. Fehler's failed experiment. You may not have reached \(galaxy.targetSystem!.name), your planned destination!"
            self.yesButton = "OK"
            self.noButton = nil
        case .SpecialTrainingCompleted:
            self.header = "Training Completed"
            self.text = "After a few hours of training with a top expert, you feel your abilities have improved significantly."
            self.yesButton = "OK"
            self.noButton = nil
        case .TravelArrival:
            self.header = "Arrival"
            self.text = "You arrive at your destination."
            self.yesButton = "OK"
            self.noButton = nil
        case .TravelUneventfulTrip:
            self.header = "Arrival"
            self.text = "After an uneventful trip, you arrive at your destination."
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesAllDied:
            self.header = "All The Tribbles Died"
            self.text = "The radiation from the Ion Reactor is deadly to Tribbles. All of the Tribbles on board your ship have died."
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesAteFood:
            self.header = "Tribbles Ate Food"
            self.text = "You find that, instead of food, some of your cargo bays contain only tribbles!"
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesGone:
            self.header = "No More Tribbles"
            self.text = "The alien uses his alien technology to beam over your whole collection of tribbles to his ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesHalfDied:
            self.header = "Half The Tribbles Died"
            self.text = "The radiation from the Ion Reactor seems to be deadly to Tribbles. Half the Tribbles on board died."
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesKilled:
            self.header = "Tribbles Killed"
            self.text = "Your tribbles all died in the explosion."
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesMostDead:
            self.header = "Most Tribbles Died"
            self.text = "You find that, instead of narcotics, some of your cargo bays contain only dead tribbles!"
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesOwn:
            self.header = "A Tribble"
            self.text = "You are now the proud owner of a little, cute, furry tribble."
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesRemoved:
            self.header = "No More Tribbles"
            self.text = "The tribbles were sold with your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesInspector:
            self.header = "Spaceport Inspector"
            self.text = "Our scan reports you have \(self.passedString1) tribbles on board your ship. Tribbles are pests worse than locusts! You are running the risk of getting a hefty fine!"
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesSqueek:
            self.header = "A Tribble"
            self.text = "Squeek!"
            self.yesButton = "OK"
            self.noButton = nil
        case .TribblesTradeIn:
            self.header = "You've Got Tribbles"
            self.text = "Hm. I see you got a tribble infestation on your current ship. I'm sorry, but that severely reduces the trade-in price."
            self.yesButton = "OK"
            self.noButton = nil
        case .WildArrested:
            self.header = "Wild Arrested"
            self.text = "Jonathan Wild is arrested, and taken away to stand trial."
            self.yesButton = "OK"
            self.noButton = nil
        case .WildChatsPirates:
            self.header = "Wild Chats With Pirates"
            self.text = "The Pirate Captain turns out to be an old associate of Jonathan Wild's. They talk about old times, and you get the feeling that Wild would switch ships if the Pirates had any quarters available."
            self.yesButton = "OK"
            self.noButton = nil
        case .WildComesAboard:
            self.header = "Jonathan Wild"
            self.text = "Jonathan Wild boards your ship. He will help out en route, but if you take too long he may become impatient and stop helping."
            self.yesButton = "OK"
            self.noButton = nil
        case .WildGoesPirates:
            self.header = "Wild Goes With Pirates"
            self.text = "The Pirate Captain turns out to be an old associate of Jonathan Wild's, and invites him to go to Kravat aboard the Pirate ship. Wild accepts the offer and thanks you for the ride."
            self.yesButton = "OK"
            self.noButton = nil
        case .WildLeavesShip:
            self.header = "Wild Leaves Ship"
            self.text = "Jonathan Wild leaves your ship, and goes into hiding on \(galaxy.currentSystem!.name)."
            self.yesButton = "OK"
            self.noButton = nil
        case .WildSculpture:
            self.header = "Wild Eyes Sculpture"
            self.text = "Jonathan Wild sees the stolen sculpture. \"Wow, I only know of one of these left in the whole Universe!\" he exclaims, \"Geurge Locas must be beside himself with it being stolen.\" He seems very impressed with you, which makes you feel much better about the item your delivering."
            self.yesButton = "OK"
            self.noButton = nil
        case .WildWontBoardLaser:
            self.header = "Wild Won't Board Ship"
            self.text = "Jonathan Wild isn't willing to go with you if you're not armed with at least a Beam Laser. He'd rather take his chances hiding out here."
            self.yesButton = "OK"
            self.noButton = nil
        case .WildWontBoardReactor:
            self.header = "Wild Won't Board Ship"
            self.text = "Jonathan Wild doesn't like the looks of that Ion Reactor. He thinks it's too dangerous, and won't get on board."
            self.yesButton = "OK"
            self.noButton = nil
        case .WildWontStayAboardLaser:
            self.header = "Wild Won't Stay Aboard"
            self.text = "Jonathan Wild isn't about to go with you if you're not armed with at least a Beam Laser. He'd rather take his chances hiding out here on \(self.passedString1)."
            self.yesButton = "Say Goodbye to Wild"
            self.noButton = "Cancel"
            self.yesIsDestructive = true
        case .WildWontStayAboardReactor:
            self.header = "Wild Won't Stay Aboard"
            self.text = "Jonathan Wild isn't willing to go with you if you bring that Reactor on board. He'd rather take his chances hiding out here on \(self.passedString1)."
            self.yesButton = "Say Goodbye to Wild"
            self.noButton = "Cancel"
            self.yesIsDestructive = true
        case .WildZeethibalAvailable:
            self.header = "Zeethibal Available"
            self.text = "To pick up Zeethibal, go to the Mercenaries for Hire screen."
            self.yesButton = "OK"
            self.noButton = nil
        }
    }
    
}

enum AlertID: Int {
    case AntidoteOnBoard = 0
    case AntidoteDestroyed
    case AntidoteTaken
    case ArrivalBuyNewspaper
    case ArrivalIFFuel
    case ArrivalIFFuelRepairs
    case ArrivalIFNewspaper
    case ArrivalIFRepairs
    case ArtifactLost
    case ArtifactOnBoard
    case ArtifactRelinquished
    case CargoIF
    case CargoNoEmptyBays
    case CargoNoneAvailable
    case CargoNoneToSell
    case CargoNotInterested
    case CargoNotSold
    case ChartJump
    case ChartJumpCurrent
    case ChartJumpNoSystemSelected
    case ChartTrackSystem
    case ChartWormholeUnreachable
    case Cheater
    case CrewFireMercenary
    case CrewNoQuarters
    case DebtNoBuy
    case DebtNone
    case DebtReminder
    case DebtTooLargeGrounded
    case DebtTooLargeLoan
    case DebtTooLargeTrade
    case DebtWarning
    case Egg
    case EncounterAliensSurrender
    case EncounterArrested
    case EncounterAttackCaptain
    case EncounterAttackNoDisruptors
    case EncounterAttackNoLasers
    case EncounterAttackNoWeapons
    case EncounterAttackPolice
    case EncounterAttackTrader
    case EncounterBothDestoryed
    case EncounterDisabledOpponent
    case EncounterDrinkContents
    case EncounterDumpAll
    case EncounterDumpWarning
    case EncounterEscaped
    case EncounterEscapeHit
    case EncounterEscapePodActivated
    case EncounterLooting
    case EncounterMarieCeleste
    case EncounterMarieCelesteNoBribe
    case EncounterOpponentEscaped
    case EncounterPiratesBounty
    case EncounterPiratesExamineReactor
    case EncounterPiratesFindNoCargo
    case EncounterPiratesSurrenderPrincess
    case EncounterPiratesTakeSculpture
    case EncounterPoliceBribe
    case EncounterPoliceBribeCant
    case EncounterPoliceBribeLowCash
    case EncounterPoliceFine
    case EncounterPoliceNothingFound
    case EncounterPoliceNothingIllegal
    case EncounterPoliceSubmit
    case EncounterPoliceSurrender
    case EncounterPostMarie
    case EncounterPostMarieFlee
    case EncounterScoop
    case EncounterScoopNoRoom
    case EncounterScoopNoScoop
    case EncounterSurrenderRefused
    case EncounterTonicConsumedGood
    case EncounterTonicConsumedStrange
    case EncounterTradeCompleted
    case EncounterYouLose
    case EncounterYouWin
    case EquipmentAlreadyOwn
    case EquipmentBuy
    case EquipmentEscapePod
    case EquipmentExtraBaysInUse
    case EquipmentFuelCompactor
    case EquipmentHiddenCompartments
    case EquipmentIF
    case EquipmentLightningShield
    case EquipmentMorgansLaser
    case EquipmentNotEnoughSlots
    case EquipmentQuantumDisruptor
    case EquipmentSell
    case FleaBuilt
    case GameAbandonConfirm
    case GameClearHighScores
    case GameEndBoughtMoon
    case GameEndBoughtMoonGirl
    case GameEndHighScoreAchieved
    case GameEndHighScoreCheat
    case GameEndHighScoreMissed
    case GameEndKilled
    case GameEndRetired
    case GameEndScore
    case GameRetire
    case HagglingComputer
    case InsuranceNoEscapePod
    case InsurancePayoff
    case InsuranceStop
    case JailConvicted
    case JailFleaReceived
    case JailHiddenCargoBaysRemoved
    case JailIllegalGoodsImpounded
    case JailInsuranceLost
    case JailMercenariesLeave
    case JailShipSold
    case JarekOnBoard
    case JarekTakenHome
    case LeavingIFInsurance
    case LeavingIFMercenaries
    case LeavingIFWormholeTax
    case MeetCaptainAhab
    case MeetCaptainConrad
    case MeetCaptainHuie
    case NewGameConfirm
    case NewGameMoreSkillPoints
    case PreciousHidden
    case PrincessComesAboard
    case PrincessTakenHome
    case ReactorConfiscated
    case ReactorDestroyed
    case ReactorOnBoard
    case ReactorMeltdown
    case ReactorWarningFuel
    case ReactorWarningFuelGone
    case ReactorWarningTemp
    case SculptureConfiscated
    case SculptureSaved
    case ShipBuyConfirm
    case ShipBuyCrewQuarters
    case ShipBuyIF
    case ShipBuyIFTransfer
    case ShipBuyNoSlots
    case ShipBuyNotAvailable
    case ShipBuyNoTransfer
    case ShipBuyPassengerQuarters
    case ShipBuyReactor
    case ShipBuyTransfer
    case ShipDesignIF
    case ShipDesignThanks
    case ShipHullUpgraded
    case SpecialCleanRecord
    case SpecialExperimentPerformed
    case SpecialIF
    case SpecialMoonBought
    case SpecialNoQuarters
    case SpecialNotEnoughBays
    case SpecialPassengerConcernedJarek
    case SpecialPassengerConcernedPrincess
    case SpecialPassengerConcernedWild
    case SpecialPassengerImpatientJarek
    case SpecialPassengerImpatientPrincess
    case SpecialPassengerImpatientWild
    case SpecialPassengerOnBoard
    case SpecialSealedCanisters
    case SpecialSkillIncrease
    case SpecialSpacetimeFabricRip
    case SpecialTrainingCompleted
    case TravelArrival
    case TravelUneventfulTrip
    case TribblesAllDied
    case TribblesAteFood
    case TribblesGone
    case TribblesHalfDied
    case TribblesKilled
    case TribblesMostDead
    case TribblesOwn
    case TribblesRemoved
    case TribblesInspector
    case TribblesSqueek
    case TribblesTradeIn
    case WildArrested
    case WildChatsPirates
    case WildComesAboard
    case WildGoesPirates
    case WildLeavesShip
    case WildSculpture
    case WildWontBoardLaser
    case WildWontBoardReactor
    case WildWontStayAboardLaser
    case WildWontStayAboardReactor
    case WildZeethibalAvailable
}