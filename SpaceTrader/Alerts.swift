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
        case .antidoteOnBoard:
            self.header = "Antidote"
            self.text = "Ten of your cargo bays now contain antidote for the Japori system."
            self.yesButton = "OK"
            self.noButton = nil
        case .antidoteDestroyed:
            self.header = "Antidote Destroyed"
            self.text = "The antidote for the Japori system has been destroyed with your ship. You should return to Nix and get some more."
            self.yesButton = "OK"
            self.noButton = nil
        case .antidoteTaken:
            self.header = "Antidote Taken"
            self.text = "The Space Corps removed the antidote for Japori from your ship and delivered it, fulfilling your assignment."
            self.yesButton = "OK"
            self.noButton = nil
        case .arrivalBuyNewspaper:
            self.header = "Buy Newspaper?"
            self.text = "The local newspaper costs ^1. Do you wish to buy a copy?"
            self.yesButton = "Buy Newspaper"
            self.noButton = "Cancel"
        case .arrivalIFFuel:
            self.header = "No Full Tanks"
            self.text = "You do not have enough money to buy full tanks."
            self.yesButton = "OK"
            self.noButton = nil
        case .arrivalIFFuelRepairs:
            self.header = "Not Enough Money"
            self.text = "You don't have enough money to get a full tank or full hull repairs."
            self.yesButton = "OK"
            self.noButton = nil
        case .arrivalIFNewspaper:
            self.header = "Can't Afford it!"
            self.text = "Sorry! A newspaper costs \(self.passedString1) cr. in this system. You don't have enough money!"
            self.yesButton = "OK"
            self.noButton = nil
        case .arrivalIFRepairs:
            self.header = "No Full Repairs"
            self.text = "You don't have enough money to get your hull fully repaired."
            self.yesButton = "OK"
            self.noButton = nil
        case .artifactLost:
            self.header = "Artifact Lost"
            self.text = "The alien artifact has been lost in the wreckage of your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .artifactOnBoard:
            self.header = "Artifact On Board"
            self.text = "The artifact is now in your cargo hold."
            self.yesButton = "OK"
            self.noButton = nil
        case .artifactRelinquished:
            self.header = "Artifact Relinquished"
            self.text = "The aliens take the artifact from you."
            self.yesButton = "OK"
            self.noButton = nil
        case .cargoIF:
            self.header = "Not Enough Money"
            self.text = "You don't have enough money to spend on any of these goods."
            self.yesButton = "OK"
            self.noButton = nil
        case .cargoNoEmptyBays:
            self.header = "No Empty Bays"
            self.text = "You don't have any empty cargo holds available at the moment."
            self.yesButton = "OK"
            self.noButton = nil
        case .cargoNoneAvailable:
            self.header = "Nothing Available"
            self.text = "None of these goods are available."
            self.yesButton = "OK"
            self.noButton = nil
        case .cargoNoneToSell:
            self.header = "No \(self.passedString1) To Sell"
            self.text = "You have none of these goods in your cargo bays."
            self.yesButton = "OK"
            self.noButton = nil
        case .cargoNotInterested:
            self.header = "Not Interested"
            self.text = "Nobody in this system is interested in buying these goods."
            self.yesButton = "OK"
            self.noButton = nil
        case .cargoNotSold:
            self.header = "Not Available"
            self.text = "That item is not available in this system."
            self.yesButton = "OK"
            self.noButton = nil
        case .chartJump:
            self.header = "Use Singularity?"
            self.text = "Do you wish to use the Portable Singularity to transport immediately to \(self.passedString1)?"
            self.yesButton = "Use Singularity"
            self.noButton = "Don't use it"
            self.yesIsDestructive = true
        case .chartJumpCurrent:
            self.header = "Cannot Jump"
            self.text = "You are tracking the system where you are currently located. It's useless to jump to your current location."
            self.yesButton = "OK"
            self.noButton = nil
        case .chartJumpNoSystemSelected:
            self.header = "No System Selected"
            self.text = "To use the Portable Singularity, track a system before clicking on this button."
            self.yesButton = "OK"
            self.noButton = nil
        case .chartTrackSystem:
            self.header = "Track System?"
            self.text = "Track \(self.passedString1)?"
            self.yesButton = "Yes"
            self.noButton = "No"
        case .chartWormholeUnreachable:
            self.header = "Wormhole Unreachable"
            self.text = "The wormhole to \(self.passedString1) is only accessible from \(self.passedString2)."
            self.yesButton = "OK"
            self.noButton = nil
        case .cheater:
            self.header = "Cheater!"
            self.text = "Cheaters never prosper!  (Well, not with that command, anyway.)"
            self.yesButton = "OK"
            self.noButton = nil
        case .crewFireMercenary:
            self.header = "Fire Mercenary?"
            self.text = "Are you sure you wish to fire \(self.passedString1)?"
            self.yesButton = "Yes"
            self.noButton = "No"
        case .crewNoQuarters:
            self.header = "No Quarters Available"
            self.text = "You do not have any crew quarters available for \(self.passedString1)."
            self.yesButton = "OK"
            self.noButton = nil
        case .debtNoBuy:
            self.header = "You Have a Debt"
            self.text = "You can't buy that as long as you have debts."
            self.yesButton = "OK"
            self.noButton = nil
        case .debtNone:
            self.header = "No Debt"
            self.text = "You have no debts."
            self.yesButton = "OK"
            self.noButton = nil
        case .debtReminder:
            self.header = "Loan Notification"
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let debtFormatted = numberFormatter.string(from: NSNumber(value: player.debt))!
            self.text = "The Bank's Loan Officer reminds you that your debt continues to accrue interest. You currently owe \(debtFormatted) cr."
            self.yesButton = "OK"
            self.noButton = nil
        case .debtTooLargeGrounded:
            self.header = "Large Debt"
            self.text = "Your debt is too large.  You are not allowed to leave this system until your debt is lowered."
            self.yesButton = "OK"
            self.noButton = nil
        case .debtTooLargeLoan:
            self.header = "Debt Too High"
            self.text = "Your debt is too high to get another loan."
            self.yesButton = "OK"
            self.noButton = nil
        case .debtTooLargeTrade:
            self.header = "Large Debt"
            self.text = "Your debt is too large. Nobody will trade with you."
            self.yesButton = "OK"
            self.noButton = nil
        case .debtWarning:
            self.header = "Warning: Large Debt"
            self.text = "Your debt is getting too large. Reduce it quickly or your ship will be put on a chain!"
            self.yesButton = "OK"
            self.noButton = nil
        case .egg:
            self.header = "Egg"
            self.text = "Congratulations! An eccentric Easter Bunny decides to exchange your trade goods for a special present!"
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterAliensSurrender:
            self.header = "Surrender"
            self.text = "If you surrender to the aliens, they will take the artifact. Are you sure you wish to do that?"
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterArrested:
            self.header = "Arrested"
            self.text = "You are arrested and taken to the space station, where you are brought before a court of law."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterAttackCaptain:
            self.header = "Really Attack?"
            self.text = "Famous Captains get famous by, among other things, destroying everyone who attacks them. Do you really want to attack?"
            self.yesButton = "Really Attack"
            self.noButton = "OK, I Won't"
            self.yesIsDestructive = true
        case .encounterAttackNoDisruptors:
            self.header = "No Disabling Weapons"
            self.text = "You have no disabling weapons! You would only be able to destroy your opponent, which would defeat the purpose of your quest."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterAttackNoLasers:
            self.header = "No Hull-Damaging Weapons"
            self.text = "You only have disabling weapons, but your opponent cannot be disabled!"
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterAttackNoWeapons:
            self.header = "No Weapons"
            self.text = "You can't attack without weapons!"
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterAttackPolice:
            self.header = "Attack Police"
            self.text = "Are you sure you wish to attack the police? This will turn you into a criminal!"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .encounterAttackTrader:
            self.header = "Attack Trader"
            self.text = "Are you sure you wish to attack the trader? This will immediately set your police record to dubious!"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .encounterBothDestoryed:
            self.header = "Both Destroyed"
            self.text = "You and your opponent have managed to destroy each other."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterDisabledOpponent:
            self.header = "Opponent Disabled"
            self.text = "You have disabled your opponent. Without life support they'll have to hibernate. You notify Space Corps, and they come and tow the \(self.passedString1) to the planet \(self.passedString2), where the crew is revived and then arrested."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterDrinkContents:
            self.header = "Drink Contents?"
            self.text = "You have come across an extremely rare bottle of Captain Marmoset's Amazing Skill Tonic! The \"use-by\" date is illegible, but might still be good.  Would you like to drink it?"
            self.yesButton = "Yes, Drink It"
            self.noButton = "No"
        case .encounterDumpAll:
            self.header = "Dump All?"
            self.text = "You paid \(self.passedString1) credits for these items. Are you sure you want to just dump them?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .encounterDumpWarning:
            self.header = "Space Littering"
            self.text = "Dumping cargo in space is considered littering. If the police find your dumped goods and track them to you, this will influence your record. Do you really wish to dump?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .encounterEscaped:
            self.header = "Escaped"
            self.text = "You have managed to escape your opponent."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterEscapeHit:
            self.header = "You Escaped"
            self.text = "You got hit, but still managed to escape."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterEscapePodActivated:
            self.header = "Escape Pod Activated"
            self.text = "ust before the final demise of your ship, your escape pod gets activated and ejects you. After a few days, the Space Corps picks you up and drops you off at a nearby space port."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterLooting:
            self.header = "Looting"
            self.text = "The pirates board your ship and transfer as much of your cargo to their own ship as their cargo bays can hold."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterMarieCeleste:
            self.header = "Engage Marie Celeste"
            self.text = "The ship is empty: there is nothing in the ship's log, but the crew has vanished, leaving food on the tables and cargo in the holds. Do you wish to offload the cargo to your own holds?"
            self.yesButton = "Yes"
            self.noButton = "No"
        case .encounterMarieCelesteNoBribe:
            self.header = "No Bribe"
            self.text = "We'd love to take your money, but Space Command already knows you've got illegal goods onboard."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterOpponentEscaped:
            self.header = "Opponent Escaped"
            self.text = "Your opponent has managed to escape."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPiratesBounty:
            self.header = "Bounty"
            self.text = "You \(self.passedString1) the pirate ship and earned a bounty of \(self.passedString2) cr."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPiratesExamineReactor:
            self.header = "Pirates Examine Reactor"
            self.text = "The pirates poke around the Ion Reactor while trying to figure out if it's valuable. They finally conclude that the Reactor is worthless, not to mention dangerous, and leave it on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPiratesFindNoCargo:
            self.header = "Pirates Find No Cargo"
            self.text = "The pirates are very angry that they find no cargo on your ship. To stop them from destroying you, you have no choice but to pay them an amount equal to 5% of your current worth \(self.passedString1)."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPiratesSurrenderPrincess:
            self.header = "You Have The Princess"
            self.text = "Pirates are not nice people, and there's no telling what they might do to the Princess. Better to die fighting than give her up to them!"
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPiratesTakeSculpture:
            self.header = "Pirates Take Sculpture"
            self.text = "As the pirates ransack your ship, they find the stolen sculpture. \"This is worth thousands!\" one pirate exclaims, as he stuffs it into his pack."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPoliceBribe:
            self.header = "Bribe"
            self.text = "These police officers are willing to forego inspection for the amount of \(self.passedString1)."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPoliceBribeCant:
            self.header = "No Bribe"
            self.text = "These police officers can't be bribed."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPoliceBribeLowCash:
            self.header = "Not Enough Cash"
            self.text = "You don't have enough cash for a bribe."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPoliceFine:
            self.header = "Caught"
            self.text = "The police discover illegal goods in your cargo holds. These goods are impounded and you are fined \(self.passedString1) credits."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPoliceNothingFound:
            self.header = "Nothing Found"
            self.text = "The police find nothing illegal in your cargo holds, and apologize for the inconvenience."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPoliceNothingIllegal:
            self.header = "You Have Nothing Illegal"
            self.text = "Are you sure you want to do that? You are not carrying illegal goods, so you have nothing to fear!"
            self.yesButton = "Yes, I still want to"
            self.noButton = "OK, I Won't"
            self.yesIsDestructive = true
        case .encounterPoliceSubmit:
            self.header = "You Have Illegal Goods"
            self.text = "Are you sure you want to let the police search you? You are carrying \(self.passedString1)!"
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPoliceSurrender:
            self.header = "Surrender"
            self.text = "If you surrender, you will spend some time in prison and will have to pay a hefty fine. Are you sure you want to do that?"
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPostMarie:
            self.header = "Contraband Removed"
            self.text = "The Customs Police confiscated all of your illegal cargo, but since you were cooperative, you avoided stronger fines or penalties."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterPostMarieFlee:
            self.header = "Criminal Act!"
            self.text = "Are you sure you want to do that? The Customs Police know you have engaged in criminal activity, and will report it!"
            self.yesButton = "Yes, I still want to"
            self.noButton = "OK, I won't"
        case .encounterScoop:
            self.header = "Scoop Canister"
            self.text = "A canister from the destroyed ship, labeled \(self.passedString1), drifts within range of your scoops."
            self.yesButton = "Pick It Up"
            self.noButton = "Let It Go"
        case .encounterScoopNoRoom:
            self.header = "No Room To Scoop"
            self.text = "You don't have any room in your cargo holds. Do you wish to jettison goods to make room, or just let it go?"
            self.yesButton = "Make Room"
            self.noButton = "Let It Go"
        case .encounterScoopNoScoop:
            self.header = "No Scoop"
            self.text = "You regret finding nothing in your holds that can be dumped, and let the canister go."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterSurrenderRefused:
            self.header = "To The Death!"
            self.text = "Surrender? Hah! We want your HEAD!"
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterTonicConsumedGood:
            self.header = "Tonic Consumed"
            self.text = "Mmmmm. Captain Marmoset's Amazing Skill Tonic not only fills you with energy, but tastes like a fine single-malt."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterTonicConsumedStrange:
            self.header = "Tonic Consumed"
            self.text = "While you don't know what it was supposed to taste like, you get the feeling that this dose of tonic was a bit off."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterTradeCompleted:
            self.header = "Trade Completed"
            self.text = "Thanks for the \(self.passedString1). It's been a pleasure doing business with you."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterYouLose:
            self.header = "You Lose"
            self.text = "Your ship has been destroyed by your opponent."
            self.yesButton = "OK"
            self.noButton = nil
        case .encounterYouWin:
            self.header = "You Win"
            self.text = "You have destroyed your opponent."
            self.yesButton = "OK"
            self.noButton = nil
        case .equipmentAlreadyOwn:
            self.header = "You Already Have One"
            self.text = "It's not useful to buy more than one of this item."
            self.yesButton = "OK"
            self.noButton = nil
        case .equipmentBuy:
            self.header = "Buy \(self.passedString1)?"
            self.text = "Do you wish to buy this item for \(self.passedString1) credits?"
            self.yesButton = "Yes"
            self.noButton = "No"
        case .equipmentEscapePod:
            self.header = "Escape Pod"
            self.text = "Do you want to buy an escape pod for 2,000 credits?"
            self.yesButton = "Yes"
            self.noButton = "No"
        case .equipmentExtraBaysInUse:
            self.header = "Cargo Bays Full"
            self.text = "The extra cargo bays are still filled with goods. You can only sell them when they're empty."
            self.yesButton = "OK"
            self.noButton = nil
        case .equipmentFuelCompactor:
            self.header = "Fuel Compactor"
            self.text = "You now have a fuel compactor installed on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .equipmentHiddenCompartments:
            self.header = "Hidden Compartments"
            self.text = "You now have hidden compartments equivalent to 5 extra cargo bays installed in your ship. Police won't find illegal cargo hidden in these compartments."
            self.yesButton = "OK"
            self.noButton = nil
        case .equipmentIF:
            self.header = "Not Enough Money"
            self.text = "You don't have enough money to spend on this item."
            self.yesButton = "OK"
            self.noButton = nil
        case .equipmentLightningShield:
            self.header = "Lightning Shield"
            self.text = "You now have one lightning shield installed on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .equipmentMorgansLaser:
            self.header = "Morgan's Laser"
            self.text = "You now have Henry Morgans special laser installed on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .equipmentNotEnoughSlots:
            self.header = "Not Enough Slots"
            self.text = "You have already filled all of your available slots for this type of item."
            self.yesButton = "OK"
            self.noButton = nil
        case .equipmentQuantumDisruptor:
            self.header = "Quantum Disruptor"
            self.text = "You now have one quantum disruptor installed on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .equipmentSell:
            self.header = "Sell Item"
            self.text = "Are you sure you want to sell this item?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .fleaBuilt:
            self.header = "Flea Built"
            self.text = "In 3 days and with 500 credits, you manage to convert your pod into a Flea."
            self.yesButton = "OK"
            self.noButton = nil
        case .gameAbandonConfirm:
            self.header = "Are You Sure?"
            self.text = "Are you sure you want to abandon your current game?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .gameClearHighScores:
            self.header = "Clear High Scores?"
            self.text = "Are you sure you wish to clear the high score table?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .gameEndBoughtMoon:
            self.header = "Retirement"
            self.text = "You have retired to your own moon."
            self.yesButton = "OK"
            self.noButton = nil
        case .gameEndBoughtMoonGirl:
            self.header = "Retirement"
            self.text = "You have retired with the Princess."
            self.yesButton = "OK"
            self.noButton = nil
        case .gameEndHighScoreAchieved:
            self.header = "Congratulations!"
            self.text = "You have made the high-score list!"
            self.yesButton = "OK"
            self.noButton = nil
        case .gameEndHighScoreCheat:
            self.header = "Naughty, Naughty!"
            self.text = "You would have made the high-score list if you weren't a Cheat!"
            self.yesButton = "OK"
            self.noButton = nil
        case .gameEndHighScoreMissed:
            self.header = "Sorry"
            self.text = "Alas! This is not enough to enter the high-score list."
            self.yesButton = "OK"
            self.noButton = nil
        case .gameEndKilled:
            self.header = "Game Over"
            self.text = "You are dead."
            self.yesButton = "OK"
            self.noButton = nil
        case .gameEndRetired:
            self.header = "Retirement"
            self.text = "You retire to a remote, volcanic planet."
            self.yesButton = "OK"
            self.noButton = nil
        case .gameEndScore:
            self.header = "Score"
            self.text = "You achieved a score of \(self.passedString1)."
            self.yesButton = "OK"
            self.noButton = nil
        case .gameRetire:
            self.header = "Retire?"
            self.text = "Are you sure you wish to retire?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .hagglingComputer:
            self.header = "Haggling Computer"
            self.text = "You now have a handheld haggling computer. It takes up very little space, and will boost your effective trading skills."
            self.yesButton = "OK"
            self.noButton = nil
        case .insuranceNoEscapePod:
            self.header = "No Escape Pod"
            self.text = "Insurance isn't useful for you, since you don't have an escape pod."
            self.yesButton = "OK"
            self.noButton = nil
        case .insurancePayoff:
            self.header = "Insurance"
            self.text = "Since your ship was insured, the bank pays you the total worth of your destroyed ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .insuranceStop:
            self.header = "Stop Insurance"
            self.text = "Do you really wish to stop your insurance and lose your no-claim?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .jailConvicted:
            self.header = "Convicted"
            self.text = "You are convicted and sentenced to \(self.passedString1) days in prison and a fine of \(self.passedString2) credits."
            self.yesButton = "OK"
            self.noButton = nil
        case .jailFleaReceived:
            self.header = "Flea Received"
            self.text = "When you leave prison, the police have left a second-hand Flea for you so you can continue your travels."
            self.yesButton = "OK"
            self.noButton = nil
        case .jailHiddenCargoBaysRemoved:
            self.header = "Hidden Compartments Removed"
            self.text = "When your ship is impounded, the police go over it with a fine-toothed comb. You hidden compartments are found and removed."
            self.yesButton = "OK"
            self.noButton = nil
        case .jailIllegalGoodsImpounded:
            self.header = "Illegal Goods Impounded"
            self.text = "The police also impound all of the illegal goods you have on board."
            self.yesButton = "OK"
            self.noButton = nil
        case .jailInsuranceLost:
            self.header = "Insurance Lost"
            self.text = "Since you cannot pay your insurance while you're in prison, it is retracted."
            self.yesButton = "OK"
            self.noButton = nil
        case .jailMercenariesLeave:
            self.header = "Mercenaries Leave"
            self.text = "Any mercenaries who were traveling with you have left."
            self.yesButton = "OK"
            self.noButton = nil
        case .jailShipSold:
            self.header = "Ship Sold"
            self.text = "Because you don't have the credits to pay your fine, your ship is sold."
            self.yesButton = "OK"
            self.noButton = nil
        case .jarekOnBoard:
            self.header = "Jarek On Board"
            self.text = "Ambassador Jarek boards your ship. While on board he will help out, but if you take too long getting him home he may become frustrated and stop helping."
            self.yesButton = "OK"
            self.noButton = nil
        case .jarekTakenHome:
            self.header = "Jarek Taken Home"
            self.text = "The Space Corps decides to give ambassador Jarek a lift home to Devidia."
            self.yesButton = "OK"
            self.noButton = nil
        case .leavingIFInsurance:
            self.header = "Not Enough Money"
            self.text = "You don't have enough cash to pay for your insurance."
            self.yesButton = "OK"
            self.noButton = nil
        case .leavingIFMercenaries:
            self.header = "Pay Mercenaries"
            self.text = "You don't have enough cash to pay your mercenaries to come with you on this trip. Fire them or make sure you have enough cash."
            self.yesButton = "OK"
            self.noButton = nil
        case .leavingIFWormholeTax:
            self.header = "Wormhole Tax"
            self.text = "You don't have enough money to pay for the wormhole tax."
            self.yesButton = "OK"
            self.noButton = nil
        case .meetCaptainAhab:
            self.header = "Meet Captain Ahab"
            self.text = "Captain Ahab is in need of a spare shield for an upcoming mission. He offers to trade you some piloting lessons for your reflective shield. Do you wish to trade?"
            self.yesButton = "Yes, Trade Shield"
            self.noButton = "No"
        case .meetCaptainConrad:
            self.header = "Meet Captain Conrad"
            self.text = "Captain Conrad is in need of a military laser. She offers to trade you some engineering training for your military laser. Do you wish to trade?"
            self.yesButton = "Yes, Trade Laser"
            self.noButton = "No"
        case .meetCaptainHuie:
            self.header = "Meet Captain Huie"
            self.text = "Captain Huie is in need of a military laser. She offers to exchange some bargaining training for your military laser. Do you wish to trade?"
            self.yesButton = "Yes, Trade Laser"
            self.noButton = "No"
        case .newGameConfirm:
            self.header = "New Game"
            self.text = "Are you sure you wish to start an new game?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .newGameMoreSkillPoints:
            self.header = "More Skill Points"
            self.text = "You haven't awarded all 20 skill points yet."
            self.yesButton = "OK"
            self.noButton = nil
        case .preciousHidden:
            self.header = "Precious Cargo Hidden"
            self.text = "You quickly hide \(self.passedString1) in your hidden cargo bays before the pirates board your ship. This would never work with the police, but pirates are usually in more of a hurry."
            self.yesButton = "OK"
            self.noButton = nil
        case .princessComesAboard:
            self.header = "Princess Comes Aboard"
            self.text = "Princess Ziyal comes aboard your ship. She'll help out en route, but if you take too long to get her home she may become annoyed and stop helping."
            self.yesButton = "OK"
            self.noButton = nil
        case .princessTakenHome:
            self.header = "Princess Taken Home"
            self.text = "The Space Corps decides to give the Princess a ride home to Galvon since you obviously weren't up to the task."
            self.yesButton = "OK"
            self.noButton = nil
        case .reactorConfiscated:
            self.header = "Police Confiscate Reactor"
            self.text = "The Police confiscate the Ion reactor as evidence of your dealings with unsavory characters."
            self.yesButton = "OK"
            self.noButton = nil
        case .reactorDestroyed:
            self.header = "Reactor Destroyed"
            self.text = "The destruction of your ship was made much more spectacular by the added explosion of the Ion Reactor."
            self.yesButton = "OK"
            self.noButton = nil
        case .reactorOnBoard:
            self.header = "Reactor"
            self.text = "Five of your cargo bays now contain the unstable Ion Reactor, and ten of your bays contain enriched fuel."
            self.yesButton = "OK"
            self.noButton = nil
        case .reactorMeltdown:
            self.header = "Reactor Meltdown!"
            self.text = "Just as you approach the docking bay, the reactor explodes into a huge radioactive fireball!"
            self.yesButton = "OK"
            self.noButton = nil
        case .reactorWarningFuel:
            self.header = "Reactor Warning"
            self.text = "You notice the Ion Reactor has begun to consume fuel rapidly. In a single day, it has burned up nearly half a bay of fuel!"
            self.yesButton = "OK"
            self.noButton = nil
        case .reactorWarningFuelGone:
            self.header = "Reactor Warning"
            self.text = "The Ion Reactor is emitting a shrill whine, and it's shaking. The display indicates that it is suffering from fuel starvation."
            self.yesButton = "OK"
            self.noButton = nil
        case .reactorWarningTemp:
            self.header = "Reactor Warning"
            self.text = "The Ion Reactor is smoking and making loud noises. The display warns that the core is close to the melting temperature."
            self.yesButton = "OK"
            self.noButton = nil
        case .sculptureConfiscated:
            self.header = "Police Confiscate Sculpture"
            self.text = "The Police confiscate the stolen sculpture and return it to its rightful owner."
            self.yesButton = "OK"
            self.noButton = nil
        case .sculptureSaved:
            self.header = "Sculpture Saved"
            self.text = "On your way to the escape pod, you grab the stolen sculpture. Oh well, at least you saved something."
            self.yesButton = "OK"
            self.noButton = nil
        case .shipBuyConfirm:
            self.header = "Buy New Ship"
            self.text = "Are you sure you wish to trade in your \(self.passedString1) for a new \(self.passedString2)?"
            self.yesButton = "Yes"
            self.noButton = "No"
            self.yesIsDestructive = true
        case .shipBuyCrewQuarters:
            self.header = "Too Many Crewmwmbers"
            self.text = "The new ship you picked doesn't have enough quarters for all of your crewmembers. First you will have to fire one or more of them."
            self.yesButton = "OK"
            self.noButton = nil
        case .shipBuyIF:
            self.header = "Not Enough Money"
            self.text = "You don't have enough money to buy this ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .shipBuyIFTransfer:
            self.header = "Not Enough Money"
            self.text = "You won't have enough money to buy this ship and pay the cost to transfer all of your unique equipment. You should choose carefully which items you wish to transfer!"
            self.yesButton = "OK"
            self.noButton = nil
        case .shipBuyNoSlots:
            self.header = "Can't Transfer Item"
            self.text = "If you trade your ship in for a \(self.passedString1), you won't be able to transfer your \(self.passedString2) because the new ship has insufficient \(self.passedString3) slots!"
            self.yesButton = "OK"
            self.noButton = nil
        case .shipBuyNotAvailable:
            self.header = "Ship Not Available"
            self.text = "That type of ship is not available in the current system."
            self.yesButton = "OK"
            self.noButton = nil
        case .shipBuyNoTransfer:
            self.header = "Can't Transfer Item"
            self.text = "Unfortunately, if you make this trade, you won't be able to afford to transfer your \(self.passedString1) to the new ship!"
            self.yesButton = "OK"
            self.noButton = nil
        case .shipBuyPassengerQuarters:
            self.header = "Passenger Needs Quarters"
            self.text = "You must get a ship with enough crew quarters so that \(self.passedString1) can stay on board."
            self.yesButton = "OK"
            self.noButton = nil
        case .shipBuyReactor:
            self.header = "Shipyard Engineer"
            self.text = "Sorry! We can't take your ship as a trade-in. That Ion Reactor looks dangerous, and we have no way of removing it. Come back when you've gotten rid of it."
            self.yesButton = "OK"
            self.noButton = nil
        case .shipBuyTransfer:
            self.header = "Transfer \(self.passedString1)"
            self.text = "I'll transfer your \(self.passedString2) to your new ship for \(self.passedString3) credits."
            self.yesButton = "Do it!"
            self.noButton = "No thanks"
        case .shipDesignIF:
            self.header = "Not Enough Money"
            self.text = "You don't have enough money to create this design."
            self.yesButton = "OK"
            self.noButton = nil
        case .shipDesignThanks:
            self.header = "Thank you!"
            self.text = "\(self.passedString1) thanks you for your business!"
            self.yesButton = "OK"
            self.noButton = nil
        case .shipHullUpgraded:
            self.header = "Hull Upgraded"
            self.text = "Technicians spend the day retrofitting the hull of your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .specialCleanRecord:
            self.header = "Clean Record"
            self.text = "The hacker resets your police record to Clean."
            self.yesButton = "OK"
            self.noButton = nil
        case .specialExperimentPerformed:
            self.header = "Experiment Performed"
            self.text = "The galaxy is abuzz with news of a terrible malfunction in Dr. Fehler's laboratory. Evidently, he was not warned in time and he performed his experiment... with disastrous results!"
            self.yesButton = "OK"
            self.noButton = nil
        case .specialIF:
            self.header = "Not Enough Money"
            self.text = "You don't have enough cash to spend to accept this offer."
            self.yesButton = "OK"
            self.noButton = nil
        case .specialMoonBought:
            self.header = "Moon Bought"
            self.text = "You bought a moon in the Utopia system. Go there to claim it."
            self.yesButton = "OK"
            self.noButton = nil
        case .specialNoQuarters:
            self.header = "No Free Quarters"
            self.text = "There are currently no free crew quarters on your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .specialNotEnoughBays:
            self.header = "Not Enough Bays"
            self.text = "You don't have enough empty cargo bays at the moment."
            self.yesButton = "OK"
            self.noButton = nil
        case .specialPassengerConcernedJarek:
            self.header = "Ship's Comm"
            self.text = "Commander? Jarek here. Do you require any assitance in charting a course to Devidia?"
            self.yesButton = "OK"
            self.noButton = nil
        case .specialPassengerConcernedPrincess:
            self.header = "Ship's Comm"
            self.text = "[Ziyal] Oh Captain? (giggles) Would it help if I got out and pushed?"
            self.yesButton = "OK"
            self.noButton = nil
        case .specialPassengerConcernedWild:
            self.header = "Ship's Comm"
            self.text = "Bridge? This is Jonathan. Are we there yet? Heh, heh. Sorry, I couldn't resist."
            self.yesButton = "OK"
            self.noButton = nil
        case .specialPassengerImpatientJarek:
            self.header = "Ship's Comm"
            self.text = "Captain! This is the Ambassador speaking. We should have been there by now?!"
            self.yesButton = "OK"
            self.noButton = nil
        case .specialPassengerImpatientPrincess:
            self.header = "Ship's Comm"
            self.text = "Sir! Are you taking me home or merely taking the place of my previous captors?!"
            self.yesButton = "OK"
            self.noButton = nil
        case .specialPassengerImpatientWild:
            self.header = "Ship's Comm"
            self.text = "Commander! Wild here. What's taking us so long?!"
            self.yesButton = "OK"
            self.noButton = nil
        case .specialPassengerOnBoard:
            self.header = "Passenger On Board"
            self.text = "You have taken \(self.passedString1) on board. While on board \(self.passedString1) will lend you expertise, but may stop helping if the journey takes too long."
            self.yesButton = "OK"
            self.noButton = nil
        case .specialSealedCanisters:
            self.header = "Sealed Canisters"
            self.text = "You bought the sealed canisters and put them in your cargo bays."
            self.yesButton = "OK"
            self.noButton = nil
        case .specialSkillIncrease:
            self.header = "Skill Increase"
            self.text = "The alien increases one of your skills."
            self.yesButton = "OK"
            self.noButton = nil
        case .specialSpacetimeFabricRip:
            self.header = "Spacetime Fabric Rip"
            self.text = "You have flown through a tear in the spacetime continuum caused by Dr. Fehler's failed experiment. You may not have reached \(galaxy.targetSystem!.name), your planned destination!"
            self.yesButton = "OK"
            self.noButton = nil
        case .specialTrainingCompleted:
            self.header = "Training Completed"
            self.text = "After a few hours of training with a top expert, you feel your abilities have improved significantly."
            self.yesButton = "OK"
            self.noButton = nil
        case .tooPoorToBuyMoon:
            self.header = "Not Enough Cash"
            self.text = "You don't have enough money to buy the moon."
            self.yesButton = "OK"
            self.noButton = nil
        case .travelArrival:
            self.header = "Arrival"
            self.text = "You arrive at your destination."
            self.yesButton = "OK"
            self.noButton = nil
        case .travelUneventfulTrip:
            self.header = "Arrival"
            self.text = "After an uneventful trip, you arrive at your destination."
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesAllDied:
            self.header = "All The Tribbles Died"
            self.text = "The radiation from the Ion Reactor is deadly to Tribbles. All of the Tribbles on board your ship have died."
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesAteFood:
            self.header = "Tribbles Ate Food"
            self.text = "You find that, instead of food, some of your cargo bays contain only tribbles!"
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesGone:
            self.header = "No More Tribbles"
            self.text = "The alien uses his alien technology to beam over your whole collection of tribbles to his ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesHalfDied:
            self.header = "Half The Tribbles Died"
            self.text = "The radiation from the Ion Reactor seems to be deadly to Tribbles. Half the Tribbles on board died."
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesKilled:
            self.header = "Tribbles Killed"
            self.text = "Your tribbles all died in the explosion."
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesMostDead:
            self.header = "Most Tribbles Died"
            self.text = "You find that, instead of narcotics, some of your cargo bays contain only dead tribbles!"
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesOwn:
            self.header = "A Tribble"
            self.text = "You are now the proud owner of a little, cute, furry tribble."
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesRemoved:
            self.header = "No More Tribbles"
            self.text = "The tribbles were sold with your ship."
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesInspector:
            self.header = "Spaceport Inspector"
            self.text = "Our scan reports you have \(player.commanderShip.tribbles) tribbles on board your ship. Tribbles are pests worse than locusts! You are running the risk of getting a hefty fine!"
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesSqueek:
            self.header = "A Tribble"
            self.text = "Squeek!"
            self.yesButton = "OK"
            self.noButton = nil
        case .tribblesTradeIn:
            self.header = "You've Got Tribbles"
            self.text = "Hm. I see you got a tribble infestation on your current ship. I'm sorry, but that severely reduces the trade-in price."
            self.yesButton = "OK"
            self.noButton = nil
        case .wildArrested:
            self.header = "Wild Arrested"
            self.text = "Jonathan Wild is arrested, and taken away to stand trial."
            self.yesButton = "OK"
            self.noButton = nil
        case .wildChatsPirates:
            self.header = "Wild Chats With Pirates"
            self.text = "The Pirate Captain turns out to be an old associate of Jonathan Wild's. They talk about old times, and you get the feeling that Wild would switch ships if the Pirates had any quarters available."
            self.yesButton = "OK"
            self.noButton = nil
        case .wildComesAboard:
            self.header = "Jonathan Wild"
            self.text = "Jonathan Wild boards your ship. He will help out en route, but if you take too long he may become impatient and stop helping."
            self.yesButton = "OK"
            self.noButton = nil
        case .wildGoesPirates:
            self.header = "Wild Goes With Pirates"
            self.text = "The Pirate Captain turns out to be an old associate of Jonathan Wild's, and invites him to go to Kravat aboard the Pirate ship. Wild accepts the offer and thanks you for the ride."
            self.yesButton = "OK"
            self.noButton = nil
        case .wildLeavesShip:
            self.header = "Wild Leaves Ship"
            self.text = "Jonathan Wild leaves your ship, and goes into hiding on \(galaxy.currentSystem!.name)."
            self.yesButton = "OK"
            self.noButton = nil
        case .wildSculpture:
            self.header = "Wild Eyes Sculpture"
            self.text = "Jonathan Wild sees the stolen sculpture. \"Wow, I only know of one of these left in the whole Universe!\" he exclaims, \"Geurge Locas must be beside himself with it being stolen.\" He seems very impressed with you, which makes you feel much better about the item your delivering."
            self.yesButton = "OK"
            self.noButton = nil
        case .wildWontBoardLaser:
            self.header = "Wild Won't Board Ship"
            self.text = "Jonathan Wild isn't willing to go with you if you're not armed with at least a Beam Laser. He'd rather take his chances hiding out here."
            self.yesButton = "OK"
            self.noButton = nil
        case .wildWontBoardReactor:
            self.header = "Wild Won't Board Ship"
            self.text = "Jonathan Wild doesn't like the looks of that Ion Reactor. He thinks it's too dangerous, and won't get on board."
            self.yesButton = "OK"
            self.noButton = nil
        case .wildWontStayAboardLaser:
            self.header = "Wild Won't Stay Aboard"
            self.text = "Jonathan Wild isn't about to go with you if you're not armed with at least a Beam Laser. He'd rather take his chances hiding out here on \(self.passedString1)."
            self.yesButton = "Say Goodbye to Wild"
            self.noButton = "Cancel"
            self.yesIsDestructive = true
        case .wildWontStayAboardReactor:
            self.header = "Wild Won't Stay Aboard"
            self.text = "Jonathan Wild isn't willing to go with you if you bring that Reactor on board. He'd rather take his chances hiding out here on \(self.passedString1)."
            self.yesButton = "Say Goodbye to Wild"
            self.noButton = "Cancel"
            self.yesIsDestructive = true
        case .wildZeethibalAvailable:
            self.header = "Zeethibal Available"
            self.text = "To pick up Zeethibal, go to the Mercenaries for Hire screen."
            self.yesButton = "OK"
            self.noButton = nil
        }
    }
    
}

enum AlertID: Int {
    case antidoteOnBoard = 0
    case antidoteDestroyed
    case antidoteTaken
    case arrivalBuyNewspaper
    case arrivalIFFuel
    case arrivalIFFuelRepairs
    case arrivalIFNewspaper
    case arrivalIFRepairs
    case artifactLost
    case artifactOnBoard
    case artifactRelinquished
    case cargoIF
    case cargoNoEmptyBays
    case cargoNoneAvailable
    case cargoNoneToSell
    case cargoNotInterested
    case cargoNotSold
    case chartJump
    case chartJumpCurrent
    case chartJumpNoSystemSelected
    case chartTrackSystem
    case chartWormholeUnreachable
    case cheater
    case crewFireMercenary
    case crewNoQuarters
    case debtNoBuy
    case debtNone
    case debtReminder
    case debtTooLargeGrounded
    case debtTooLargeLoan
    case debtTooLargeTrade
    case debtWarning
    case egg
    case encounterAliensSurrender
    case encounterArrested
    case encounterAttackCaptain
    case encounterAttackNoDisruptors
    case encounterAttackNoLasers
    case encounterAttackNoWeapons
    case encounterAttackPolice
    case encounterAttackTrader
    case encounterBothDestoryed
    case encounterDisabledOpponent
    case encounterDrinkContents
    case encounterDumpAll
    case encounterDumpWarning
    case encounterEscaped
    case encounterEscapeHit
    case encounterEscapePodActivated
    case encounterLooting
    case encounterMarieCeleste
    case encounterMarieCelesteNoBribe
    case encounterOpponentEscaped
    case encounterPiratesBounty
    case encounterPiratesExamineReactor
    case encounterPiratesFindNoCargo
    case encounterPiratesSurrenderPrincess
    case encounterPiratesTakeSculpture
    case encounterPoliceBribe
    case encounterPoliceBribeCant
    case encounterPoliceBribeLowCash
    case encounterPoliceFine
    case encounterPoliceNothingFound
    case encounterPoliceNothingIllegal
    case encounterPoliceSubmit
    case encounterPoliceSurrender
    case encounterPostMarie
    case encounterPostMarieFlee
    case encounterScoop
    case encounterScoopNoRoom
    case encounterScoopNoScoop
    case encounterSurrenderRefused
    case encounterTonicConsumedGood
    case encounterTonicConsumedStrange
    case encounterTradeCompleted
    case encounterYouLose
    case encounterYouWin
    case equipmentAlreadyOwn
    case equipmentBuy
    case equipmentEscapePod
    case equipmentExtraBaysInUse
    case equipmentFuelCompactor
    case equipmentHiddenCompartments
    case equipmentIF
    case equipmentLightningShield
    case equipmentMorgansLaser
    case equipmentNotEnoughSlots
    case equipmentQuantumDisruptor
    case equipmentSell
    case fleaBuilt
    case gameAbandonConfirm
    case gameClearHighScores
    case gameEndBoughtMoon
    case gameEndBoughtMoonGirl
    case gameEndHighScoreAchieved
    case gameEndHighScoreCheat
    case gameEndHighScoreMissed
    case gameEndKilled
    case gameEndRetired
    case gameEndScore
    case gameRetire
    case hagglingComputer
    case insuranceNoEscapePod
    case insurancePayoff
    case insuranceStop
    case jailConvicted
    case jailFleaReceived
    case jailHiddenCargoBaysRemoved
    case jailIllegalGoodsImpounded
    case jailInsuranceLost
    case jailMercenariesLeave
    case jailShipSold
    case jarekOnBoard
    case jarekTakenHome
    case leavingIFInsurance
    case leavingIFMercenaries
    case leavingIFWormholeTax
    case meetCaptainAhab
    case meetCaptainConrad
    case meetCaptainHuie
    case newGameConfirm
    case newGameMoreSkillPoints
    case preciousHidden
    case princessComesAboard
    case princessTakenHome
    case reactorConfiscated
    case reactorDestroyed
    case reactorOnBoard
    case reactorMeltdown
    case reactorWarningFuel
    case reactorWarningFuelGone
    case reactorWarningTemp
    case sculptureConfiscated
    case sculptureSaved
    case shipBuyConfirm
    case shipBuyCrewQuarters
    case shipBuyIF
    case shipBuyIFTransfer
    case shipBuyNoSlots
    case shipBuyNotAvailable
    case shipBuyNoTransfer
    case shipBuyPassengerQuarters
    case shipBuyReactor
    case shipBuyTransfer
    case shipDesignIF
    case shipDesignThanks
    case shipHullUpgraded
    case specialCleanRecord
    case specialExperimentPerformed
    case specialIF
    case specialMoonBought
    case specialNoQuarters
    case specialNotEnoughBays
    case specialPassengerConcernedJarek
    case specialPassengerConcernedPrincess
    case specialPassengerConcernedWild
    case specialPassengerImpatientJarek
    case specialPassengerImpatientPrincess
    case specialPassengerImpatientWild
    case specialPassengerOnBoard
    case specialSealedCanisters
    case specialSkillIncrease
    case specialSpacetimeFabricRip
    case specialTrainingCompleted
    case tooPoorToBuyMoon
    case travelArrival
    case travelUneventfulTrip
    case tribblesAllDied
    case tribblesAteFood
    case tribblesGone
    case tribblesHalfDied
    case tribblesKilled
    case tribblesMostDead
    case tribblesOwn
    case tribblesRemoved
    case tribblesInspector
    case tribblesSqueek
    case tribblesTradeIn
    case wildArrested
    case wildChatsPirates
    case wildComesAboard
    case wildGoesPirates
    case wildLeavesShip
    case wildSculpture
    case wildWontBoardLaser
    case wildWontBoardReactor
    case wildWontStayAboardLaser
    case wildWontStayAboardReactor
    case wildZeethibalAvailable
}
