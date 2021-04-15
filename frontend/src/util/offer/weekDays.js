export const weekDays = {
    "MONDAY": "Poniedziałek",
    "TUESDAY": "Wtorek",
    "WEDNESDAY": "Środa",
    "THURSDAY": "Czwartek",
    "FRIDAY": "Piątek",
    "SATURDAY": "Sobota",
    "SUNDAY": "Niedziela",
}

export const parseDay = (name) => (weekDays[name]);
