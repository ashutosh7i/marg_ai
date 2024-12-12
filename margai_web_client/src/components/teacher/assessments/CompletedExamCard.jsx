/* eslint-disable react/prop-types */
import { ordinalDate } from "@/utils/ordinalDate";
import { Trash2 } from "lucide-react";

function CompletedExamCard({ assessment }) {
  const {
    title,
    type,
    postedOn,
    endDate,
    completedStudentsNum,
    missingStudentsNum,
  } = assessment;

  return (
    <div className="bg-white rounded-3xl shadow-md px-6 py-4 flex flex-col">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-[#2E3A59]">{title}</h2>

        <Trash2 className="text-[#4D44B5] cursor-pointer" />
      </div>

      <p className="text-[#999] font-medium text-sm mb-1">Type: {type}</p>

      <h3 className="text-[0.9rem] font-bold text-[#8C1D18] mb-4">
        Finished: {ordinalDate(endDate, true)}
      </h3>

      <div className="text-center text-[#2E3A59] text-lg font-semibold mb-3">
        <h3>Completed: {completedStudentsNum}</h3>
        <h3>Missing: {missingStudentsNum}</h3>
      </div>

      <button className="bg-[#4D44B5] rounded-3xl mx-6 px-3 py-2 text-white font-bold mb-2">
        View Result
      </button>

      <div className="text-gray-500 text-xs text-center">
        Posted: {ordinalDate(postedOn, true)}
      </div>
    </div>
  );
}

export default CompletedExamCard;
