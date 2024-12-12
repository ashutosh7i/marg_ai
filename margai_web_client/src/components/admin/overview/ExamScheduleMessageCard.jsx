/* eslint-disable react/prop-types */

import { ordinalDate } from "@/utils/ordinalDate";
import { useState } from "react";

function ExamScheduleMessageCard({ exams = [] }) {
  const [visibleCount, setVisibleCount] = useState(2);

  const handleViewMore = () => {
    setVisibleCount((prevCount) => prevCount + 5);
  };

  return (
    <div className="w-full rounded-3xl border bg-white pt-4 px-6 pb-2 shadow-md flex flex-col">
      <h2 className="text-[#018183] text-base font-semibold text-center mb-2">
        Exam Schedule
      </h2>
      <ul className="mb-4 flex flex-col gap-2">
        {exams.slice(0, visibleCount).map((exam) => (
          <li className="text-sm" key={exam.id}>
            {exam.title} of {exam.className} is scheduled on From{" "}
            {ordinalDate(exam.date)}
          </li>
        ))}
      </ul>

      {visibleCount < exams.length && (
        <button
          onClick={handleViewMore}
          className="text-sm font-bold text-[#00494A]"
        >
          View More
        </button>
      )}
    </div>
  );
}

export default ExamScheduleMessageCard;
