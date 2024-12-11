/* eslint-disable react/prop-types */
import { useState } from "react";

function DocumentListCard({ documents }) {
  const [visibleCount, setVisibleCount] = useState(3);

  const handleViewMore = () => {
    setVisibleCount((prevCount) => (prevCount <= 3 ? 5 : 3));
  };

  return (
    <div className="w-full rounded-3xl border bg-white p-6 shadow-md">
      <div className="mb-6 flex items-center justify-between">
        <h2 className="text-xl font-semibold text-[#333]">Documents</h2>
        <button
          onClick={handleViewMore}
          className="text-sm font-bold text-[#4D44B5] hover:text-[#4D44B5]/80"
        >
          {visibleCount <= 3 ? "See All" : "See Less"}
        </button>
      </div>

      <ul className="flex flex-col gap-4">
        {documents.slice(0, visibleCount).map((doc) => (
          <DocumentItem doc={doc} key={doc.id} />
        ))}
      </ul>
    </div>
  );
}

function DocumentItem({ doc }) {
  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date
      .toLocaleString("en-US", {
        day: "2-digit",
        month: "short",
        hour: "2-digit",
        minute: "2-digit",
        hour12: true,
      })
      .replace(",", "");
  };

  return (
    <li className="flex items-center gap-8 rounded-lg bg-white/50 p-3 shadow-sm transition-all hover:bg-white hover:shadow-md">
      <div className="rounded-lg bg-[#F3F4FF] p-3">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          fill="none"
        >
          <path
            d="M10.8607 2.55225C10.5511 2.55225 10.2542 2.67523 10.0353 2.89414C9.81634 3.11306 9.69336 3.40997 9.69336 3.71956C9.69336 4.02915 9.81634 4.32606 10.0353 4.54498C10.2542 4.76389 10.5511 4.88688 10.8607 4.88688H13.1953C13.5049 4.88688 13.8018 4.76389 14.0207 4.54498C14.2396 4.32606 14.3626 4.02915 14.3626 3.71956C14.3626 3.40997 14.2396 3.11306 14.0207 2.89414C13.8018 2.67523 13.5049 2.55225 13.1953 2.55225H10.8607Z"
            fill="#4D44B5"
          />
          <path
            fillRule="evenodd"
            clipRule="evenodd"
            d="M5.02344 6.05436C5.02344 5.43517 5.26941 4.84135 5.70723 4.40352C6.14506 3.9657 6.73889 3.71973 7.35807 3.71973C7.35807 4.6485 7.72702 5.53923 8.38376 6.19598C9.04051 6.85272 9.93124 7.22167 10.86 7.22167H13.1946C14.1234 7.22167 15.0142 6.85272 15.6709 6.19598C16.3276 5.53923 16.6966 4.6485 16.6966 3.71973C17.3158 3.71973 17.9096 3.9657 18.3474 4.40352C18.7852 4.84135 19.0312 5.43517 19.0312 6.05436V18.8948C19.0312 19.514 18.7852 20.1078 18.3474 20.5457C17.9096 20.9835 17.3158 21.2295 16.6966 21.2295H7.35807C6.73889 21.2295 6.14506 20.9835 5.70723 20.5457C5.26941 20.1078 5.02344 19.514 5.02344 18.8948V6.05436ZM8.52538 10.7236C8.21579 10.7236 7.91888 10.8466 7.69997 11.0655C7.48105 11.2844 7.35807 11.5813 7.35807 11.8909C7.35807 12.2005 7.48105 12.4974 7.69997 12.7163C7.91888 12.9353 8.21579 13.0582 8.52538 13.0582H8.53706C8.84665 13.0582 9.14356 12.9353 9.36247 12.7163C9.58139 12.4974 9.70437 12.2005 9.70437 11.8909C9.70437 11.5813 9.58139 11.2844 9.36247 11.0655C9.14356 10.8466 8.84665 10.7236 8.53706 10.7236H8.52538ZM12.0273 10.7236C11.7177 10.7236 11.4208 10.8466 11.2019 11.0655C10.983 11.2844 10.86 11.5813 10.86 11.8909C10.86 12.2005 10.983 12.4974 11.2019 12.7163C11.4208 12.9353 11.7177 13.0582 12.0273 13.0582H15.5293C15.8389 13.0582 16.1358 12.9353 16.3547 12.7163C16.5736 12.4974 16.6966 12.2005 16.6966 11.8909C16.6966 11.5813 16.5736 11.2844 16.3547 11.0655C16.1358 10.8466 15.8389 10.7236 15.5293 10.7236H12.0273ZM8.52538 15.3929C8.21579 15.3929 7.91888 15.5159 7.69997 15.7348C7.48105 15.9537 7.35807 16.2506 7.35807 16.5602C7.35807 16.8698 7.48105 17.1667 7.69997 17.3856C7.91888 17.6045 8.21579 17.7275 8.52538 17.7275H8.53706C8.84665 17.7275 9.14356 17.6045 9.36247 17.3856C9.58139 17.1667 9.70437 16.8698 9.70437 16.5602C9.70437 16.2506 9.58139 15.9537 9.36247 15.7348C9.14356 15.5159 8.84665 15.3929 8.53706 15.3929H8.52538ZM12.0273 15.3929C11.7177 15.3929 11.4208 15.5159 11.2019 15.7348C10.983 15.9537 10.86 16.2506 10.86 16.5602C10.86 16.8698 10.983 17.1667 11.2019 17.3856C11.4208 17.6045 11.7177 17.7275 12.0273 17.7275H15.5293C15.8389 17.7275 16.1358 17.6045 16.3547 17.3856C16.5736 17.1667 16.6966 16.8698 16.6966 16.5602C16.6966 16.2506 16.5736 15.9537 16.3547 15.7348C16.1358 15.5159 15.8389 15.3929 15.5293 15.3929H12.0273Z"
            fill="#4D44B5"
          />
        </svg>
      </div>

      <div>
        <h3 className="mb-1 font-normal text-gray-800">{doc.title}</h3>
        <p className="text-sm text-gray-500">{formatDate(doc.date)}</p>
      </div>
    </li>
  );
}

export default DocumentListCard;