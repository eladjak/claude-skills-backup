---
name: braindump
description: Capture thoughts, ideas, and insights into the Second Brain system. Classifies and organizes automatically.
command: braindump
user_invocable: true
---

# Braindump - הטלת מחשבות למוח השני

## מתי להשתמש
- כשהמשתמש רוצה לתעד מחשבה, רעיון, תובנה
- כשנלמד לקח חשוב מעבודה
- כשיש החלטה שצריך לזכור
- כשעולה רעיון לפרויקט או שיפור

## תהליך

### 1. קבלת הקלט
המשתמש מזין מחשבה חופשית בעברית או באנגלית. אין מבנה נדרש.

### 2. סיווג אוטומטי
סווג את המחשבה לאחד מהתחומים:

| תחום | תיקייה | דוגמאות |
|------|--------|---------|
| עסקי | `knowledge/business/` | לקוח, תמחור, שיווק, הצעה |
| טכני | `knowledge/technical/` | דפוס קוד, כלי חדש, פתרון, באג |
| אישי | `knowledge/personal/` | יעד, תובנה, רעיון, השראה |
| פרויקט | `knowledge/business/projects/` | עדכון לפרויקט ספציפי |
| רעיון חדש | `braindumps/raw/` | רעיון שעדיין לא מגובש |

### 3. שמירה
```
# קובץ: braindumps/raw/YYYY-MM-DD-<slug>.md

# <כותרת קצרה>
**תאריך:** YYYY-MM-DD HH:MM
**תחום:** <business/technical/personal/project/idea>
**תגיות:** #tag1 #tag2

## תוכן
<המחשבה המקורית>

## עיבוד Claude
<ניתוח קצר: מה זה אומר, למה זה חשוב, מה לעשות עם זה>

## פעולות נדרשות
- [ ] <פעולה 1 אם רלוונטי>
- [ ] <פעולה 2 אם רלוונטי>
```

### 4. העשרה
- אם המחשבה קשורה לפרויקט קיים → הוסף הפנייה לפרויקט
- אם זו תובנה טכנית → עדכן את `knowledge/technical/`
- אם זו החלטה עסקית → עדכן את `knowledge/business/`
- אם זה משנה את הפרופיל → עדכן `profile/`

### 5. עדכון קנבן (חובה!)
אחרי כל braindump:
- אם יש פרויקט רלוונטי → עדכן PROGRESS.md שלו
- עדכן את `~/.claude/projects-registry.json` אם יש שינוי סטטוס
- הודע למשתמש מה עודכן

## דוגמאות

### קלט: "חשבתי שאולי כדאי להוסיף לאיתן הפקות אינטגרציה עם Monday.com כי אלון כבר עובד שם"
```
תחום: project (איתן הפקות)
תגיות: #eitan-events #monday #integration #alon
עיבוד: תובנה חשובה - האינטגרציה עם Monday תקל על אימוץ המערכת כי אלון כבר משתמש בה.
פעולה: להוסיף לתכנון Phase 2 של הפרויקט.
```

### קלט: "למדתי שב-Convex אפשר להשתמש ב-crons לתזמון משימות"
```
תחום: technical
תגיות: #convex #crons #scheduling
עיבוד: כלי שימושי לפרויקטים שמשתמשים ב-Convex (haderech-next, eitan-events).
פעולה: לתעד ב-knowledge/technical/convex-patterns.md
```

### קלט: "אני חושב שצריך להעלות מחירים, 8000 זה נמוך מדי ל-MVP"
```
תחום: business
תגיות: #pricing #business-model
עיבוד: עדכון תמחור. לבדוק מול שוק ולעדכן business/overview.md
פעולה: לעדכן טבלת תמחור
```

## פלט למשתמש
בסיום הראה:
```
📝 Braindump נשמר!
📁 תחום: <business/technical/personal>
🏷️ תגיות: #tag1 #tag2
📋 פעולות: <מספר פעולות שנוצרו>
🔄 עודכן: <קבצים שעודכנו>
```

## קבצים
- **בסיס:** `~/.claude/second-brain/`
- **גולמי:** `braindumps/raw/YYYY-MM-DD-*.md`
- **מעובד:** `braindumps/processed/` (כשמצטבר מספיק חומר)
- **ידע:** `knowledge/<domain>/`
