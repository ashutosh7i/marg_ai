/* eslint-disable react/prop-types */
import { useState } from "react";
import { useTranslation } from "react-i18next";

function TestListCard({ tests }) {
  const { t } = useTranslation("teacher-tests-list-card");
  const [visibleCount, setVisibleCount] = useState(3);

  const handleViewMore = () => {
    setVisibleCount((prevCount) => (prevCount <= 3 ? 5 : 3));
  };

  return (
    <div className="w-full rounded-3xl border bg-white p-6 shadow-md">
      <div className="mb-6 flex items-center justify-between">
        <h2 className="text-xl font-semibold text-[#333]">{t("Tests")}</h2>
        <button
          className="text-sm font-bold text-[#4D44B5] hover:text-[#4D44B5]/80"
          onClick={handleViewMore}
        >
          {visibleCount <= 3 ? t("See All") : t("See Less")}
        </button>
      </div>

      <ul className="flex flex-col gap-4">
        {tests.slice(0, visibleCount).map((test) => (
          <TestItem test={test} key={test.id} />
        ))}
      </ul>
    </div>
  );
}

function TestItem({ test }) {
  return (
    <li className="flex items-center gap-3 rounded-3xl bg-white/50 p-3 shadow-sm transition-all hover:bg-white hover:shadow-md">
      <div className="h-12 w-12 rounded-xl bg-[#F0F7FF] p-2 text-center text-xl font-semibold text-[#4D44B5]">
        {test.class}
      </div>

      <div className="flex-1">
        <h3 className="mb-1 font-medium text-gray-800">{test.title}</h3>
        <p className="line-clamp-1 text-sm text-[#8A8A8A]">{test.message}</p>
      </div>

      <p className="text-xs font-bold text-[#8A8A8A]">{test.time}</p>
    </li>
  );
}

export default TestListCard;
