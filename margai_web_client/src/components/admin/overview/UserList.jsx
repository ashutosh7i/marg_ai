/* eslint-disable react/prop-types */
import { Mail, Plus, User } from "lucide-react";
import { useState } from "react";

function UserList({ title, userList = [] }) {
  const [visibleCount, setVisibleCount] = useState(3);

  const handleViewMore = () => {
    setVisibleCount((prevCount) => prevCount + 5);
  };

  return (
    <div className="w-full rounded-3xl border bg-white shadow-md flex flex-col p-6 pb-4">
      <div className="flex items-center justify-between">
        <div>
          <h3 className="font-poppins mb-2 text-2xl font-bold text-[#125354]">
            {title}
          </h3>
        </div>

        <button className="rounded-full  bg-[#018183] p-3">
          <Plus className="h-6 w-6 text-black" />
        </button>
      </div>
      <ul className="mt-7 mb-4">
        {userList.slice(0, visibleCount).map((student) => (
          <li
            key={student.name}
            className="mb-4 flex items-center justify-between gap-2"
          >
            <div className="flex items-center gap-4">
              <button className="rounded-full  bg-[#018183] p-3">
                <User className="h-6 w-6 text-black" />
              </button>
              <div className="flex flex-col">
                <h4 className="text-lg font-semibold text-[#303972]">
                  {student.name}
                </h4>
              </div>
            </div>
            <button className="rounded-full  bg-[#018183] p-3">
              <Mail className="h-6 w-6 text-black" />
            </button>
          </li>
        ))}
      </ul>

      {visibleCount < userList.length && (
        <button
          onClick={handleViewMore}
          className="text-sm font-bold text-[#125354]"
        >
          View More
        </button>
      )}
    </div>
  );
}

export default UserList;
