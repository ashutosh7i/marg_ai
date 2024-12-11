import { Button } from "@/components/ui/button";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { format, parseISO, isEqual } from "date-fns";
import { useMemo, useState } from "react";
import { events } from "@/data/data";

function ScheduleCard() {
  const [currentDate, setCurrentDate] = useState(new Date());

  // Group and sort events by date
  const groupedEvents = useMemo(() => {
    return events.reduce((acc, event) => {
      const date = parseISO(event.date);
      const dateKey = format(date, "yyyy-MM-dd");

      if (!acc[dateKey]) {
        acc[dateKey] = [];
      }
      acc[dateKey].push(event);
      return acc;
    }, {});
  }, [events]);

  // Get events for current date
  const currentEvents = useMemo(() => {
    const dateKey = format(currentDate, "yyyy-MM-dd");
    return groupedEvents[dateKey] || [];
  }, [groupedEvents, currentDate]);

  // Navigation handlers
  const goToPreviousDay = () => {
    setCurrentDate((prev) => {
      const newDate = new Date(prev);
      newDate.setDate(prev.getDate() - 1);
      return newDate;
    });
  };

  const goToNextDay = () => {
    setCurrentDate((prev) => {
      const newDate = new Date(prev);
      newDate.setDate(prev.getDate() + 1);
      return newDate;
    });
  };

  const isToday = useMemo(() => {
    return isEqual(
      new Date(currentDate.setHours(0, 0, 0, 0)),
      new Date(new Date().setHours(0, 0, 0, 0))
    );
  }, [currentDate]);

  return (
    <div className="rounded-3xl border bg-white p-4 text-card-foreground shadow-sm md:p-6">
      <div className="flex items-center justify-between">
        <Button
          variant="ghost"
          size="icon"
          onClick={goToPreviousDay}
          className="text-[#4D44B5] hover:bg-[#4D44B5]/10"
        >
          <ChevronLeft className="h-5 w-5" />
        </Button>

        <h2 className="relative text-center text-2xl font-bold text-[#303972] after:absolute after:-bottom-2 after:left-1/2 after:h-1 after:w-16 after:-translate-x-1/2 after:rounded-full after:bg-[#4D44B5]/20">
          {isToday ? "Today's Schedule" : format(currentDate, "MMMM d, yyyy")}
        </h2>

        <Button
          variant="ghost"
          size="icon"
          onClick={goToNextDay}
          className="text-[#4D44B5] hover:bg-[#4D44B5]/10"
        >
          <ChevronRight className="h-5 w-5" />
        </Button>
      </div>

      {currentEvents.length > 0 ? (
        <ul className="mt-8 flex flex-col gap-4">
          {currentEvents.map((event) => (
            <li
              key={event.id}
              className="relative flex items-center justify-between rounded-lg bg-white/50 p-4 shadow-sm transition-all hover:bg-white hover:shadow-md"
            >
              <div className="flex items-center gap-4">
                <div className="h-2 w-2 rounded-full bg-[#4D44B5]" />
                <p className="text-lg font-bold text-[#303972]">
                  {event.title}
                </p>
              </div>
              <div className="flex flex-col items-end gap-1">
                <p className="text-sm font-medium text-[#303972]">
                  <span className="rounded-full bg-[#4D44B5]/10 px-3 py-1 text-sm font-medium text-[#4D44B5]">
                    {event.class}
                  </span>
                </p>
                <p className="text-sm font-semibold text-[#A098AE]">
                  {event.time}
                </p>
              </div>
            </li>
          ))}
        </ul>
      ) : (
        <div className="mt-8 flex h-[200px] items-center justify-center rounded-lg bg-white/50">
          <p className="text-lg text-[#A098AE]">No events scheduled</p>
        </div>
      )}
    </div>
  );
}

export default ScheduleCard;
