
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Dialog, DialogContent, DialogTitle } from "@/components/ui/dialog";
import { format } from "date-fns";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { T } from "react-router/dist/development/fog-of-war-DU_DzpDb";
import { useTranslation } from "react-i18next";

const HOURS = Array.from({ length: 24 }, (_, i) => i);

const TeacherScheduleCalendar = () => {
  const [currentDate, setCurrentDate] = useState(new Date());
  const [notes, setNotes] = useState({});
  const [selectedDay, setSelectedDay] = useState(null);
  const [isDialogOpen, setIsDialogOpen] = useState(false);
  const [noteText, setNoteText] = useState("");
  const [timeRange, setTimeRange] = useState({ start: "", end: "" });

  const handleSaveNote = (e) => {
    if (!noteText || !timeRange.start || !timeRange.end) return;

    console.log(e);

    const dateKey = `${currentDate.getFullYear()}-${currentDate.getMonth()}-${selectedDay}`;
    setNotes((prev) => ({
      ...prev,
      [dateKey]: { note: noteText, timeRange },
    }));
    setIsDialogOpen(false);
    setSelectedDay(null);
    setNoteText("");
    setTimeRange({ start: "", end: "" });
  };

  const renderTimelineGrid = () => {
    const daysToShow = 7; // Show a week of dates
    const dates = Array.from({ length: daysToShow }, (_, i) => {
      const date = new Date(currentDate);
      date.setDate(currentDate.getDate() + i);
      return date;
    });
    const { t } = useTranslation("teacher-events-UpcomingEventsCard");
    return (
      <div className="mt-2">
        <div className="mb-4 flex items-center justify-between">
          <h2 className="mb-6 text-2xl font-bold text-[#303972]">
            {T("mycal")}
          </h2>

          <div className="flex gap-2">
            <Button
              variant="ghost"
              onClick={() => {
                const newDate = new Date(currentDate);
                newDate.setDate(newDate.getDate() - 7);
                setCurrentDate(newDate);
              }}
              className="text-[#4D44B5]"
            >
              <ChevronLeft className="h-5 w-5" />
            </Button>
            <Button
              variant="ghost"
              onClick={() => {
                const newDate = new Date(currentDate);
                newDate.setDate(newDate.getDate() + 7);
                setCurrentDate(newDate);
              }}
              className="text-[#4D44B5]"
            >
              <ChevronRight className="h-5 w-5" />
            </Button>
          </div>
        </div>

        <div className="overflow-x-auto">
          <div className="min-w-[800px]">
            {/* Header row with dates */}
            <div className="grid grid-cols-[100px_repeat(7,1fr)] gap-1">
              <div className="p-2 font-medium text-[#303972]"></div>
              {dates.map((date) => (
                <div
                  key={date.toISOString()}
                  className="p-2 text-center font-medium"
                >
                  <div>{format(date, "dd MMM")}</div>
                  <div className="text-[#8A8A8A]">{format(date, "EEE")}</div>
                </div>
              ))}
            </div>

            {/* Time slots grid */}
            <div className="max-h-[600px] overflow-y-auto">
              {HOURS.map((hour) => {
                const timeStr = `${hour.toString().padStart(2, "0")}:00`;
                const endTimeStr = `${(hour + 1)
                  .toString()
                  .padStart(2, "0")}:00`;

                return (
                  <div
                    key={hour}
                    className="grid grid-cols-[100px_repeat(7,1fr)] gap-1 border-t border-gray-100"
                  >
                    {/* Time column */}
                    <div className="p-2 text-xs font-medium text-[#3C3C3C]">
                      {timeStr} - {endTimeStr}
                    </div>

                    {/* Date columns */}
                    {dates.map((date) => {
                      const dateKey = `${date.getFullYear()}-${date.getMonth()}-${date.getDate()}`;
                      const note = notes[dateKey];
                      const hasNoteInHour =
                        note &&
                        (note.timeRange.start.startsWith(timeStr) ||
                          (parseInt(note.timeRange.start) <= hour &&
                            parseInt(note.timeRange.end) > hour));

                      return (
                        <div
                          key={date.toISOString()}
                          className="group relative min-h-[60px] border-l p-10"
                          onClick={() => {
                            setSelectedDay(date.getDate());
                            setTimeRange({
                              start: timeStr,
                              end: `${(hour + 1)
                                .toString()
                                .padStart(2, "0")}:00`,
                            });
                            setIsDialogOpen(true);
                          }}
                        >
                          {hasNoteInHour && (
                            <div className="absolute inset-1 rounded bg-[#8147E7] p-1">
                              <p className="mb-2 line-clamp-2 text-xs font-medium text-white/70">
                                {note.note}
                              </p>
                              <p className="text-xs text-white">
                                {note.timeRange.start} - {note.timeRange.end}
                              </p>
                            </div>
                          )}
                          <Button
                            variant="ghost"
                            className="absolute inset-0 h-full w-full opacity-0"
                          >
                            <span className="sr-only">Add note</span>
                          </Button>
                        </div>
                      );
                    })}
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      </div>
    );
  };

  return (
    <div className="mx-8 rounded-3xl border bg-white p-4 text-card-foreground shadow-sm md:p-6">
      {renderTimelineGrid()}

      {/* Add Note Dialog */}
      <Dialog open={isDialogOpen} onOpenChange={setIsDialogOpen}>
        <DialogContent className="sm:max-w-[425px]">
          <DialogTitle className="text-[#303972]">
            Add Note for{" "}
            {selectedDay &&
              format(
                new Date(
                  currentDate.getFullYear(),
                  currentDate.getMonth(),
                  selectedDay
                ),
                "MMMM d, yyyy"
              )}
          </DialogTitle>
          <div className="mt-4 flex flex-col gap-4">
            <div>
              <label className="text-sm font-medium text-[#303972]">Note</label>
              <input
                type="text"
                placeholder="Enter your note"
                value={noteText}
                onChange={(e) => setNoteText(e.target.value)}
                className="mt-1 w-full rounded-md border border-[#E2E8F0] px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#4D44B5]"
              />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="text-sm font-medium text-[#303972]">
                  {t("starttime")}
                </label>
                <input
                  type="time"
                  value={timeRange.start}
                  onChange={(e) =>
                    setTimeRange((prev) => ({ ...prev, start: e.target.value }))
                  }
                  className="mt-1 w-full rounded-md border border-[#E2E8F0] px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#4D44B5]"
                />
              </div>
              <div>
                <label className="text-sm font-medium text-[#303972]">
                  {t("endtime")}
                </label>
                <input
                  type="time"
                  value={timeRange.end}
                  onChange={(e) =>
                    setTimeRange((prev) => ({ ...prev, end: e.target.value }))
                  }
                  className="mt-1 w-full rounded-md border border-[#E2E8F0] px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-[#4D44B5]"
                />
              </div>
            </div>
            <Button
              onClick={handleSaveNote}
              className="mt-2 bg-[#4D44B5] text-white hover:bg-[#4D44B5]/90"
            >
              {t("SaveNote")}
            </Button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
};

export default TeacherScheduleCalendar;
