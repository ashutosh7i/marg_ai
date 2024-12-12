/* eslint-disable react/prop-types */
import { format } from "date-fns";
import { useState } from "react";
import { useTranslation } from "react-i18next";


const nthNumber = (number) => {
  if (number > 3 && number < 21) return "th";
  switch (number % 10) {
    case 1:
      return "st";
    case 2:
      return "nd";
    case 3:
      return "rd";
    default:
      return "th";
  }
};

function UpcomingExamsCard({ upcomingExams }) {
  const [visibleCount, setVisibleCount] = useState(3);

  const handleViewMore = () => {
    setVisibleCount((prevCount) => (prevCount <= 3 ? 5 : 3));
  };
  const { t } = useTranslation("teacher-events-UpcomingEventsCard");
  return (
    <div className="mx-8 mb-4 rounded-3xl border bg-white p-4 text-card-foreground shadow-sm md:p-6">
      <div className="mb-6 flex items-center justify-between">
        <h3 className="text-2xl font-bold text-[#303972]">{t("Upcoming Events")}</h3>
        <button
          onClick={handleViewMore}
          className="text-sx font-bold text-[#4D44B5] hover:text-[#4D44B5]/80"
        >
          {visibleCount <= 3 ? t("See All") : t("See Less")}
        </button>
      </div>

      <ul className="flex flex-col gap-4">
        {upcomingExams.slice(0, visibleCount).map((activity) => (
          <li
            className="grid grid-cols-[15%_60%_20%] rounded-xl bg-[#F3F4FF] p-6 shadow-sm transition-all hover:shadow-md"
            key={activity.id}
          >
            <p className="flex h-12 w-12 items-center justify-center rounded-xl bg-[#4D44B5] px-12 py-4 text-xl font-semibold text-[#FFF]">
              {format(new Date(activity.date), "dd")}
            </p>

            <div className="flex flex-col">
              <h3 className="mb-1 text-xl font-bold text-[#333]">
                {activity.title}
              </h3>
              <div className="flex gap-6">
                <button className="line-clamp-1 cursor-pointer text-xs font-semibold text-[#4D44B5] underline">
                  {t("addquestion")}
                </button>
                {/*TODO: {new Date(activity.date) < new Date() ? :} */}
                <span className="text-xs font-semibold text-[#FF9924]">
                  {t("todo")}
                </span>
                <span className="text-xs font-semibold text-[#FF1515]">
                  {t("duesoon")}
                </span>
              </div>
            </div>

            <div className="flex items-center gap-4">
              <div className="h-3 w-3 rounded-full bg-[#4D44B5]" />
              <p className="text-sm font-semibold text-[#8A8A8A]">
                {new Date(activity.date).getDate()}
                {nthNumber(new Date(activity.date).getDate())}{" "}
                {new Date(activity.date).toLocaleString("en-US", {
                  month: "short",
                })}{" "}
                {activity.startTime}
              </p>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default UpcomingExamsCard;
