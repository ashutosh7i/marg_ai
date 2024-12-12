import { useTranslation } from "react-i18next";

function Banner() {
  const { t } = useTranslation("overview-banner");

  return (
    <div className="grid h-[10.9375rem] grid-cols-[60%_40%] rounded-[1.25rem] bg-[#4D44B5] text-white mb-8">
      <div className="flex flex-col justify-center px-10">
        <h2 className="text-[2rem] font-bold">{t("greeting")} 👋</h2>

        <p className="w-[80%] text-wrap text-[0.9375rem] font-normal">
          {t("message")}
        </p>
      </div>

      <img
        src="img/home-page-banner.png"
        alt="banner"
        width={390}
        height={200}
        className="translate-y-2"
      />
    </div>
  );
}

export default Banner;
