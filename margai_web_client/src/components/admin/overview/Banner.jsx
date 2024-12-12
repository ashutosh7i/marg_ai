function Banner() {
  return (
    <div className="grid h-[10.9375rem] grid-cols-[60%_40%] rounded-[1.25rem] bg-[#018183] text-white">
      <div className="flex flex-col justify-center px-10">
        <h2 className="text-2xl font-bold">Hello, Admin_name! 👋</h2>

        <p className="w-[80%] text-wrap text-[0.9375rem] font-normal">
          You have 27 new tests created in your institution. Monitor 5 ongoing
          assessments or view results of 7 ended assessments.
        </p>
      </div>

      <img
        src="img/admin-overview-banner.png"
        alt="banner"
        width={1040}
        height={780}
        className="translate-y-[0.5rem]"
      />
    </div>
  );
}

export default Banner;
