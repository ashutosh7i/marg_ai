/* eslint-disable react/prop-types */
import { useState } from "react";
import { Button } from "@/components/ui/button";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { cn } from "@/lib/utils";
import { ChevronDown } from "lucide-react";
import { useTranslation } from "react-i18next";

const SchoolCalendar = ({ events }) => {
  const { t } = useTranslation("teacher-schoolcalendar");

  const YEARS = Array.from(
    { length: 9 },
    (_, i) => new Date().getFullYear() - 3 + i
  );

  const MONTHS = [
    t("January"),
    t("February"),
    t("March"),
    t("April"),
    t("May"),
    t("June"),
    t("July"),
    t("August"),
    t("September"),
    t("October"),
    t("November"),
    t("December"),
  ];

  const EVENT_TYPES = {
    TEST: {
      name: t("Test"),
      color: "bg-[#FB7D5B]  rounded-full px-4 py-3 text-white",
      dotColor: "bg-[#FB7D5B]",
      textColor: "text-[#FB7D5B]",
    },
    ASSIGNMENT: {
      name: t("Assignment"),
      color: "bg-[#FCC43E]  rounded-full px-4 py-3 text-white",
      dotColor: "bg-[#FCC43E]",
      textColor: "text-[#FCC43E]",
    },
  };

  const [currentDate, setCurrentDate] = useState(new Date());

  const daysInMonth = new Date(
    currentDate.getFullYear(),
    currentDate.getMonth() + 1,
    0
  ).getDate();

  const firstDayOfMonth = new Date(
    currentDate.getFullYear(),
    currentDate.getMonth(),
    1
  ).getDay();

  const getEventForDate = (day) => {
    const dateKey = `${currentDate.getFullYear()}-${currentDate.getMonth()}-${day}`;
    return events[dateKey];
  };

  const renderCalendarDays = () => {
    const days = [];
    for (let i = 1; i <= daysInMonth; i++) {
      const event = getEventForDate(i);
      const eventClass = event ? EVENT_TYPES[event].color : "hover:bg-white/80";

      // Calculate if it's a Sunday
      const date = new Date(
        currentDate.getFullYear(),
        currentDate.getMonth(),
        i
      );
      const isSunday = date.getDay() === 0;

      days.push(
        <Button
          key={i}
          variant="ghost"
          className="relative aspect-square h-full w-full p-0 border-2 rounded-none"
          aria-label={`${i} ${currentDate.toLocaleString("default", {
            month: "long",
          })} ${currentDate.getFullYear()}`}
        >
          <span
            className={cn(
              "absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 text-lg",
              isSunday && "font-medium text-[#303972]",
              event && eventClass
            )}
          >
            {i}
          </span>
        </Button>
      );
    }
    return days;
  };

  return (
    <div
      className="rounded-3xl border bg-white p-4 shadow-md md:p-6"
      role="region"
      aria-label="School Calendar"
    >
      <div className="mb-6 flex flex-col items-start justify-between gap-4 sm:flex-row sm:items-center">
        <h2 className="text-2xl font-bold text-[#303972]">School Calendar</h2>

        <Popover>
          <PopoverTrigger asChild>
            <Button variant="outline" className="min-w-[140px] justify-between">
              {currentDate.toLocaleString("default", {
                month: "long",
                year: "numeric",
              })}
              <ChevronDown className="ml-2 h-4 w-4 opacity-50" />
            </Button>
          </PopoverTrigger>
          <PopoverContent className="w-64 p-2" align="end">
            <div className="mb-2 font-medium text-center">{t("Month")}</div>
            <div className="grid grid-cols-3">
              {MONTHS.map((month, index) => (
                <Button
                  key={month}
                  variant="ghost"
                  size="sm"
                  onClick={() =>
                    setCurrentDate(
                      new Date(currentDate.getFullYear(), index, 1)
                    )
                  }
                  className={cn(
                    "justify-center transition-all duration-300 ease-in-out transform ",
                    currentDate.getMonth() === index && "bg-muted"
                  )}
                >
                  {month.slice(0, 3)}
                </Button>
              ))}
            </div>
            <div className="mb-2 mt-4 font-medium text-center">{t("Year")}</div>
            <div className="grid grid-cols-3 gap-1">
              {YEARS.map((year) => (
                <Button
                  key={year}
                  variant="ghost"
                  size="sm"
                  onClick={() =>
                    setCurrentDate(new Date(year, currentDate.getMonth(), 1))
                  }
                  className={cn(
                    "justify-center transition-all duration-300 ease-in-out transform ",
                    currentDate.getFullYear() === year && "bg-muted"
                  )}
                >
                  {year}
                </Button>
              ))}
            </div>
          </PopoverContent>
        </Popover>
      </div>

      {/* Calendar Grid */}
      <div className="mb-4 grid grid-cols-7 gap-1">
        {[
          t("Sun"),
          t("Mon"),
          t("Tue"),
          t("Wed"),
          t("Thu"),
          t("Fri"),
          t("Sat"),
        ].map((day, index) => (
          <div
            key={day}
            className={cn(
              "text-center text-sm font-medium text-muted-foreground text-[#A098AE]",
              index === 0 && "text-[#FB7D5B]"
            )}
          >
            {day}
          </div>
        ))}
      </div>

      <div
        className="grid grid-cols-7 "
        style={{
          gridTemplateRows: `repeat(${Math.ceil(
            (daysInMonth + firstDayOfMonth) / 7
          )}, auto)`,
        }}
      >
        {Array(firstDayOfMonth)
          .fill(null)
          .map((_, index) => (
            <div
              key={`empty-${index}`}
              className="aspect-square"
              aria-hidden="true"
            />
          ))}
        {renderCalendarDays()}
      </div>

      {/* Legend */}
      <div className="mt-4 flex gap-4">
        {Object.entries(EVENT_TYPES).map(([type, { name, dotColor }]) => (
          <div key={type} className="flex items-center gap-2">
            <div className={cn("h-4 w-4 rounded", dotColor)} />
            <span className="text-sm text-muted-foreground">{name}</span>
          </div>
        ))}
      </div>
    </div>
  );
};

export default SchoolCalendar;
