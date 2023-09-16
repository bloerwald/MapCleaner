# MapCleaner

Filter annoying WoW world map clutter! You define what is shown there, not Blizzard. Just add area POI, vignette or quest IDs and to a filter list and enjoy a plain map. Do you want spam

![A screenshot of Zaralekk Cavern on a dead realm with loads of rares up.](./.readme/before.png)

or just what you're interested in and nothing more?

![A screenshot of Zaralekk Cavern on the same realm, but with only two rares showing.](./.readme/after.png)

## Usage

It is strongly suggested to use the [idTip](https://github.com/ItsJustMeChris/idTip-Community-Fork) addon to find IDs to filter **way** more easily.

Use the `/mapcleaner` or `/mc` slash command:
- `/mc filtervignette 1331` removes vignette 1331 from your map.
- `/mc filterpoi 1331` removes area POI 1331 from your map.
- `/mc filterquest 1331` removes area quest 1331 from your map.
- `/mc unfiltervignette 1331`, `/mc unfilterpoi 1331` and `/mc unfilterquest 1331` reverses that.
- `/mc listfiltered` gives you a list with everything you removed.
- `/mc listvisible` gives a load of POIs, vignettes and quests that can be filtered. The [idTip](https://github.com/ItsJustMeChris/idTip-Community-Fork) addon is **way** superior to this list since it allows you to hover an annoying icon and just see the ID rather than searching in this way too long list.
