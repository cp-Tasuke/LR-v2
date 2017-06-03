﻿#region

using wServer.logic.behaviors;
using wServer.logic.loot;
using wServer.logic.transitions;

#endregion

namespace wServer.logic
{
    partial class BehaviorDb
    {
        private _ Manor = () => Behav()
        //lord ruthven is waaay unfinished
        .Init("Tombstone",
            new State(
                new TransformOnDeath("Kage Kami", 1, 1, 0.25, true),
                new State("idle"),
                new State("get rekt",
                    new Suicide()
                    )
                )
            )
        .Init("Kage Kami",
            new State(
                new DropPortalOnDeath("Manor of the Immortals Portal", 50, PortalDespawnTimeSec: 60),
                new State("wait",
                    new EntityNotExistsTransition("Tombstone", 29, "default"),
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new ReturnToSpawn(false, 0.5),
                    new SetAltTexture(2),
                    new Taunt(1.0,
                        "Kyoufu no kage!",
                        "You brought this upon yourself!",
                        "Fear me!!",
                        "Fear the shadows!",
                        "You shall pay!!!",
                        "You shall pay for sullying this hallowed earth!",
                        "Who dares to desecrate this sacred ground?",
                        "You dare to desecrate this sacred ground?"),
                    new Follow(0.3, range: 6),
                    new Shoot(8, count: 6, coolDown: 1000, fixedAngle: 0, shootAngle: 60, projectileIndex: 0),
                    new Shoot(6, count: 1, coolDown: 2150, projectileIndex: 1)
                    ),
                new State("default",
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new SetAltTexture(1),
                    new Taunt(1.0,
                        "Kyoufu no kage!",
                        "You brought this upon yourself!",
                        "Fear me!!",
                        "Fear the shadows!",
                        "You shall pay!!!",
                        "You shall pay for sullying this hallowed earth!",
                        "Who dares to desecrate this sacred ground?",
                        "You dare to desecrate this sacred ground?"),
                        new TimedTransition(6000, "start battle")
                    ),
                new State("start battle",
                    new UnsetConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new SetAltTexture(1),
                    new Taunt(1.0,
                        "Kyoufu no kage!",
                        "You brought this upon yourself!",
                        "Fear me!!",
                        "Fear the shadows!",
                        "You shall pay!!!",
                        "You shall pay for sullying this hallowed earth!",
                        "Who dares to desecrate this sacred ground?",
                        "You dare to desecrate this sacred ground?"),
                    new Follow(0.3, range: 6),
                    new Shoot(8, count: 6, coolDown: 1000, fixedAngle: 0, shootAngle: 60, projectileIndex: 0),
                    new Shoot(6, count: 1, coolDown: 2150, projectileIndex: 1),
                    new TimedTransition(5000, "second stage")
                    ),
                new State("second stage",
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new SetAltTexture(2),
                    new Taunt(1.0,
                        "Kyoufu no kage!",
                        "You brought this upon yourself!",
                        "Fear me!!",
                        "Fear the shadows!",
                        "You shall pay!!!",
                        "You shall pay for sullying this hallowed earth!",
                        "Who dares to desecrate this sacred ground?",
                        "You dare to desecrate this sacred ground?"),
                    new Follow(1, range: 12),
                    new Shoot(8, count: 6, coolDown: 750, fixedAngle: 0, shootAngle: 60, projectileIndex: 0),
                    new Shoot(6, count: 1, coolDown: 2150, projectileIndex: 1),
                    new TimedTransition(8500, "third stage")
                    ),
                new State("third stage",
                    new ConditionalEffect(ConditionEffectIndex.Invulnerable),
                    new SetAltTexture(1),
                    new Taunt(1.0,
                        "Kyoufu no kage!",
                        "You brought this upon yourself!",
                        "Fear me!!",
                        "Fear the shadows!",
                        "You shall pay!!!",
                        "You shall pay for sullying this hallowed earth!",
                        "Who dares to desecrate this sacred ground?",
                        "You dare to desecrate this sacred ground?"),
                    new TimedTransition(3000, "start battle")
                    )
                )
            )
                    .Init("Lord Ruthven",
                new State(
                    new TransformOnDeath("Coffin", 1, 2, 0.35, true),
                    new RealmPortalDrop(),
                    new State("default",
                        new PlayerWithinTransition(8, "spooksters")
                        ),
                    new State("spooksters",
                        new Wander(0.2),
                        //new Shoot(10, count: 5, shootAngle: 2, projectileIndex: 0, coolDown: 900),
                        new Shoot(10, 18, 20, projectileIndex: 0, fixedAngle: 1, coolDown: 900),
                        new TimedTransition(6000, "spooksters2")
                        ),
                    new State("spooksters2",
                        new Wander(0.15),
                        new Shoot(8.4, count: 40, projectileIndex: 1, coolDown: 2750),
                        new Shoot(10, 18, 20, projectileIndex: 0, fixedAngle: 1, coolDown: 900),
                        new Shoot(10, count: 5, shootAngle: 2, projectileIndex: 0, coolDown: 900),
                        new TimedTransition(4000, "spooksters3")
                        ),
                    new State("spooksters3",
                        new Heal(5, "Self", coolDown: 1250),
                        new Shoot(8.4, count: 40, projectileIndex: 1, coolDown: 2750),
                        new TimedTransition(4000, "spooksters")
                        )
                    ),
                new MostDamagers(5,
                    new ItemLoot("Potion of Attack", 1),
                    new ItemLoot("Holy Water", 1),
                    new ItemLoot("Death Tarot Card", awesomeloot),
                    new ItemLoot("Wine Cellar Incantation", winecellar),
                    new TierLoot(7, ItemType.Weapon, mediumloot),
                    new TierLoot(8, ItemType.Weapon, mediumloot),
                    new TierLoot(9, ItemType.Weapon, normalloot),
                    new TierLoot(6, ItemType.Armor, poorloot),
                    new TierLoot(6, ItemType.Armor, poorloot),
                    new TierLoot(4, ItemType.Ability, normalloot),
                    new TierLoot(5, ItemType.Ability, goodloot),
                    new TierLoot(4, ItemType.Ring, normalloot),
                    new ItemLoot("Holy Cross", awesomeloot),
                    new ItemLoot("Golden Candelabra", awesomeloot)
                    ),
                new MostDamagers(3,
                    new ItemLoot("Chasuble of Holy Light", awesomeloot),
                    new ItemLoot("St. Abraham's Wand", awesomeloot),
                    new OnlyOne(
                        new ItemLoot("Tome of Purification", whitebag),
                        new ItemLoot("Shattered War-axe", whitebag)
                        ),
                    new ItemLoot("Ring of Divine Faith", awesomeloot),
                    new ItemLoot("Bone Dagger", awesomeloot)
                    )
            )
            .Init("Hellhound",
                new State(
                    new Follow(1.25, 8, 1, coolDown: 275),
                    new Shoot(10, count: 5, shootAngle: 7, coolDown: 2000)
                    ),
                new ItemLoot("Health Potion", 0.05),
                new Threshold(0.5,
                    new ItemLoot("Timelock Orb", 0.01)
                    )
            )
                    .Init("Vampire Bat Swarmer",
                new State(
                    new State("start",
                        new Follow(1.5, 8, 1),
                        new Shoot(10, count: 1, coolDown: 6),
                        new TimedTransition(5000, "morre")
                        ),
                    new State("morre",
                        new Suicide()
                        )
                    )
            )
                    .Init("Lil Feratu",
                new State(
                    new Follow(0.35, 8, 1),
                    new Shoot(10, count: 6, shootAngle: 2, coolDown: 900)
                    ),
                new ItemLoot("Magic Potion", 0.05),
                new Threshold(0.5,
                    new ItemLoot("Steel Helm", 0.01)
                    )
            )
                            .Init("Lesser Bald Vampire",
                new State(
                    new Follow(0.35, 8, 1),
                    new Shoot(10, count: 5, shootAngle: 6, coolDown: 1000)
                    ),
                new ItemLoot("Magic Potion", 0.05),
                new Threshold(0.5,
                    new ItemLoot("Steel Helm", 0.01)
                    )
            )
                  .Init("Nosferatu",
                new State(
                    new Wander(0.25),
                    new Shoot(10, count: 5, shootAngle: 2, projectileIndex: 1, coolDown: 1000),
                    new Shoot(10, count: 6, shootAngle: 90, projectileIndex: 0, coolDown: 1500)
                    ),
                new ItemLoot("Magic Potion", 0.05),
                new Threshold(0.5,
                    new ItemLoot("Bone Dagger", awesomeloot),
                    new ItemLoot("Wand of Death", 0.05),
                    new ItemLoot("Golden Bow", 0.04),
                    new ItemLoot("Steel Helm", 0.05),
                    new ItemLoot("Ring of Paramount Defense", 0.09)
                    )
            )
                          .Init("Armor Guard",
                new State(
                    new Wander(0.2),
                    new TossObject("RockBomb", 7, coolDown: 3000, randomToss: true),
                    new Shoot(10, count: 1, projectileIndex: 0, predictive: 7, coolDown: 1000),
                    new Shoot(10, count: 1, projectileIndex: 1, coolDown: 750)
                    ),
                new ItemLoot("Health Potion", 0.05),
                new Threshold(0.5,
                    new ItemLoot("Glass Sword", 0.01),
                    new ItemLoot("Staff of Destruction", 0.01),
                    new ItemLoot("Golden Shield", 0.01),
                    new ItemLoot("Ring of Paramount Speed", 0.01)
                    )
            )
                                  .Init("Coffin Creature",
                new State(
                    new Spawn("Lil Feratu", initialSpawn: 1, maxChildren: 2, coolDown: 2250),
                    new Shoot(10, count: 1, projectileIndex: 0, coolDown: 700)
                    ),
                new ItemLoot("Health Potion", 0.05)
            )
                              .Init("RockBomb",
                        new State(
                    new State("BOUTTOEXPLODE",
                    new TimedTransition(1111, "boom")
                        ),
                    new State("boom",
                        new Shoot(8.4, count: 1, fixedAngle: 0, projectileIndex: 0, coolDown: 1000),
                        new Shoot(8.4, count: 1, fixedAngle: 90, projectileIndex: 0, coolDown: 1000),
                        new Shoot(8.4, count: 1, fixedAngle: 180, projectileIndex: 0, coolDown: 1000),
                        new Shoot(8.4, count: 1, fixedAngle: 270, projectileIndex: 0, coolDown: 1000),
                        new Shoot(8.4, count: 1, fixedAngle: 45, projectileIndex: 0, coolDown: 1000),
                        new Shoot(8.4, count: 1, fixedAngle: 135, projectileIndex: 0, coolDown: 1000),
                        new Shoot(8.4, count: 1, fixedAngle: 235, projectileIndex: 0, coolDown: 1000),
                        new Shoot(8.4, count: 1, fixedAngle: 315, projectileIndex: 0, coolDown: 1000),
                       new Suicide()
                    )
            )
    )
           .Init("Coffin",
                        new State(
                    new State("Coffin1",
                        new HpLessTransition(0.75, "Coffin2")
                        ),
                    new State("Coffin2",
                        new Spawn("Vampire Bat Swarmer", initialSpawn: 1, maxChildren: 15, coolDown: 99999),
                         new HpLessTransition(0.40, "Coffin3")
                        ),
                       new State("Coffin3",
                           new Spawn("Vampire Bat Swarmer", initialSpawn: 1, maxChildren: 8, coolDown: 99999),
                            new Spawn("Nosferatu", initialSpawn: 1, maxChildren: 2, coolDown: 99999)
                        )
                ),
                        new MostDamagers(4,
                            new ItemLoot("Potion of Attack", 0.5),
                            new ItemLoot("Wine Cellar Incantation", winecellar),
                            new ItemLoot("Chasuble of Holy Light", awesomeloot),
                            new ItemLoot("St. Abraham's Wand", awesomeloot),
                            new OnlyOne(
                                new ItemLoot("Tome of Purification", whitebag)
                                ),
                            new ItemLoot("Ring of Divine Faith", awesomeloot),
                            new ItemLoot("Bone Dagger", awesomeloot)
                            ),
                        new Threshold(1,
                            new ItemLoot("Holy Water", 1),
                            new TierLoot(7, ItemType.Weapon, mediumloot),
                            new TierLoot(8, ItemType.Weapon, mediumloot),
                            new TierLoot(9, ItemType.Weapon, normalloot),
                            new TierLoot(6, ItemType.Armor, poorloot),
                            new TierLoot(6, ItemType.Armor, poorloot),
                            new TierLoot(4, ItemType.Ability, normalloot),
                            new TierLoot(5, ItemType.Ability, goodloot),
                            new TierLoot(4, ItemType.Ring, normalloot)
                            )
            );
    }
}