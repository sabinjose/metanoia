# Plan: Spiritual Invitation for Returning/Anxious Penitents

## Overview
Create a profound spiritual invitation that meets users who are returning to confession after many years or feeling anxious about the sacrament. This combines charismatic warmth, traditional Catholic depth, and Scripture.

## Target Users
1. **Prodigal sons/daughters** - Haven't confessed in years, feel distant from God
2. **Anxious penitents** - Afraid, ashamed, overwhelmed, don't know where to start

## Implementation Approach

### 1. Gentle Popup on First Examination Start
**Trigger:** When user taps "Start Examination" for the FIRST time (track via SharedPreferences)

**Dialog Content:**
- Warm, non-judgmental question
- Two options: "Yes, I need encouragement" → Opens invitation screen | "No, I'm ready" → Proceeds to examination
- "Don't show again" checkbox

**UI:** Soft dialog with heart/dove icon, warm colors

---

### 2. Dedicated "Come Home" Screen (in Guide)
**Location:** New screen accessible from Guide menu AND from the popup

**Screen Name:** "An Invitation to Grace" / "Come Home"

**Content Structure (Scrollable):**

#### Section A: Opening Invitation
- Personal, Spirit-filled welcome
- "If you're reading this, the Holy Spirit is already at work..."
- Acknowledge the courage it takes

#### Section B: For Those Returning After Years
- Address the fear: "Perhaps it's been 5, 10, 20 years or more..."
- Scripture: Luke 15 (Prodigal Son) - The Father RUNS to meet you
- Scripture: Isaiah 1:18 - "Though your sins be as scarlet..."
- Saint quote: St. John Vianney on God's eagerness to forgive
- Reassurance: The priest has heard everything, he will help you

#### Section C: For Those Feeling Anxious
Address specific fears:
1. **"My sins are too terrible"**
   - Scripture: Romans 8:38-39 - Nothing can separate you from God's love
   - St. Faustina: "The greater the sinner, the greater the right to My mercy"

2. **"The priest will judge me"**
   - The priest represents Christ who came for sinners
   - Seal of confession - absolute confidentiality
   - Priests rejoice when prodigals return

3. **"I can't remember everything"**
   - God knows your heart
   - Confess what you remember, mention "and any sins I've forgotten"
   - The priest will guide you

#### Section D: Practical Encouragement
- "You don't have to be perfect to start"
- "The examination will guide you step by step"
- "Take your time - drafts are saved"

#### Section E: A Prayer for Courage
- Short prayer invoking the Holy Spirit
- Prayer to Our Lady for intercession

#### Section F: Call to Action
- "Begin Your Examination" button
- "Read the Guide First" link
- "View Prayers" link

---

### 3. Guide Screen Enhancement
**Add entry point:** New card at top of Guide screen
- Title: "Returning to Confession?" or "Feeling Anxious?"
- Subtitle: "A word of encouragement for you"
- Tapping opens the invitation screen

---

## Files to Modify/Create

### New Files:
1. `lib/src/features/guide/presentation/invitation_screen.dart` - The main invitation screen
2. `assets/data/invitation/invitation_en.json` - English content
3. `assets/data/invitation/invitation_ml.json` - Malayalam content

### Modified Files:
1. `lib/src/core/router/app_router.dart` - Add route for invitation screen
2. `lib/src/features/guide/presentation/guide_screen.dart` - Add invitation card
3. `lib/src/features/examination/presentation/examination_screen.dart` - Add first-time popup trigger
4. `lib/src/core/localization/l10n/app_en.arb` - Add localization strings
5. `lib/src/core/localization/l10n/app_ml.arb` - Add Malayalam strings
6. `lib/src/core/database/tables.dart` - May need invitation table if storing in DB
7. `lib/src/core/database/app_database.dart` - Database updates if needed

---

## Content Draft (English)

### Opening:
> **Come Home**
>
> If you're reading this, something has stirred in your heart. Perhaps it's been years since your last confession. Perhaps you're afraid. Perhaps you feel unworthy.
>
> Know this: **You are not here by accident.** The same God who left the ninety-nine to find the one lost sheep has been seeking you. He has never stopped loving you.

### For Those Returning:
> **"But it's been so long..."**
>
> Whether it's been 5 years, 20 years, or a lifetime - the Father is not counting the days you were away. He is watching the road, waiting for you to appear on the horizon. And when He sees you, **He will run to meet you** (Luke 15:20).
>
> *"Come now, let us settle the matter," says the LORD. "Though your sins are like scarlet, they shall be as white as snow."* — Isaiah 1:18

### For the Anxious:
> **"My sins are too terrible..."**
>
> There is no sin that God's mercy cannot cover. St. Faustina heard Jesus say: *"The greater the sinner, the greater the right he has to My mercy."*
>
> **"The priest will judge me..."**
>
> The priest sits in the confessional as Christ's representative - and Christ came not for the righteous, but for sinners. Every priest has heard confessions that would shock you. Yours will not be the worst. And when a prodigal returns, there is **joy** in that confessional.
>
> **"I can't remember everything..."**
>
> You don't have to. Confess what you remember with honesty. Say "and any sins I have forgotten." God sees your heart. The priest will help you.

### Closing:
> **You Are Ready**
>
> You don't need to have it all figured out. You don't need to feel worthy. You just need to come.
>
> The examination will guide you. The priest will help you. And God? He's already preparing the celebration.
>
> *"There will be more rejoicing in heaven over one sinner who repents than over ninety-nine righteous persons who do not need to repent."* — Luke 15:7

---

## Implementation Steps

1. **Create new branch:** `git checkout -b feature/spiritual-invitation`
2. Create invitation content JSON files (EN + ML)
3. Create InvitationScreen widget with scrollable content
4. Add routing for invitation screen
5. Add invitation card to Guide screen
6. Implement first-examination popup dialog
7. Add SharedPreferences flag for "has seen invitation popup"
8. Add localization strings
9. Test both light and dark themes
10. Git commit on feature branch

---

## Design Notes

- Use EB Garamond font for Scripture quotes (spiritual elegance)
- Warm gradient background (similar to onboarding)
- Soft icons (dove, heart, open arms)
- Generous padding and spacing for contemplative reading
- Support pull-to-refresh or swipe gestures
- Ensure proper dark/light theme support

---

## User Confirmations

- **Placement:** Guide screen with popup trigger on first examination start ✓
- **Tone:** Blend of charismatic warmth, traditional reverence, and Prodigal Son narrative ✓
- **Content:** Scripture passages + pastoral acknowledgment of fears ✓
- **Languages:** Both English and Malayalam ✓
- **Fears to address:** Shame/unworthiness, fear of priest, overwhelm at years of sin ✓
- **Additional saints/devotions:** Draft content approved as-is ✓
