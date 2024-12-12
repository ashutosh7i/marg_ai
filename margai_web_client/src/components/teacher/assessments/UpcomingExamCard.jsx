/* eslint-disable react/prop-types */
import { ordinalDate } from "@/utils/ordinalDate";
import { FilePenLine, Sparkles, Trash2 } from "lucide-react";
import { Link } from "react-router";

function UpcomingExamCard({ assessment, link }) {
  const {
    title,
    type,
    postedOn,
    endDate,
    areQuestionsAdded,
    assignedStudentsNum,
    startingDate,
  } = assessment;

  return (
    <div className="bg-white rounded-3xl shadow-md px-6 py-4 pb-2 flex flex-col">
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-semibold text-[#2E3A59] mb-1">{title}</h2>

        <div className="flex gap-1">
          <FilePenLine className="text-[#4D44B5] cursor-pointer" />
          <Trash2 className="text-[#4D44B5] cursor-pointer" />
        </div>
      </div>

      <div className="mb-3">
        <p className="text-[#999] font-medium text-sm">Type: {type}</p>
        <p className="text-[#999] font-medium text-sm">
          Status:{" "}
          {!areQuestionsAdded ? (
            <span className="text-[#FF9500]">Submission Pending</span>
          ) : (
            <span className="text-[#34C759]">Questions Submitted</span>
          )}
        </p>

        <h3 className="text-[0.9rem] font-bold text-[#8C1D18]">
          Deadline: {ordinalDate(endDate, true)}
        </h3>
      </div>

      <div className="text-center text-[#2E3A59] text-lg font-semibold mb-3">
        <h3>Assigned: {assignedStudentsNum}</h3>
        <h3>Starts on: {ordinalDate(startingDate, true)}</h3>
      </div>

      <div className="flex gap-2 text-white font-bold justify-center mb-2">
        <Link to={link}>
          <button className="bg-[#4D44B5] rounded-3xl px-4 py-1">
            Add Questions
          </button>
        </Link>
        <Link to="/teacher/generate-questions">
          <button className="bg-[#4D44B5] p-2 rounded-full">
            <Sparkles />
          </button>
        </Link>
      </div>

      <div className="text-gray-500 text-xs text-center ">
        Posted on: {ordinalDate(postedOn, true)}
      </div>
    </div>
  );
}

export default UpcomingExamCard;
