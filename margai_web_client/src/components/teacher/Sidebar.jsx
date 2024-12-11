import { useTranslation } from "react-i18next";
import { Link, useLocation } from "react-router";

function Sidebar() {
  const { pathname } = useLocation();
  const { t } = useTranslation("teacher-sidebar");

  const menuItems = [
    {
      id: 1,
      name: t("Overview"),
      activeIcon: "/img/teacher-sidebar/overview-active.svg",
      inactiveIcon: "/img/teacher-sidebar/overview.svg",
      path: "/teacher",
    },
    {
      id: 2,
      name: t("Students"),
      activeIcon: "/img/teacher-sidebar/students-active.svg",
      inactiveIcon: "/img/teacher-sidebar/students.svg",
      path: "/teacher/students",
    },
    {
      id: 3,
      name: t("Assessments"),
      activeIcon: "/img/teacher-sidebar/assessments-active.svg",
      inactiveIcon: "/img/teacher-sidebar/assessments.svg",
      path: "/teacher/assessments",
    },
    // {
    //   id: 4,
    //   name: t("Resources"),
    //   activeIcon: "/img/teacher-sidebar/resources-active.svg",
    //   inactiveIcon: "/img/teacher-sidebar/resources.svg",
    //   path: "/teacher/resources",
    // },
    {
      id: 5,
      name: t("Result Analytics"),
      activeIcon: "/img/teacher-sidebar/result-analytics-active.svg",
      inactiveIcon: "/img/teacher-sidebar/result-analytics.svg",
      path: "/teacher/result-analytics",
    },
    {
      id: 6,
      name: t("Schedule"),
      activeIcon: "/img/teacher-sidebar/events-active.svg",
      inactiveIcon: "/img/teacher-sidebar/events.svg",
      path: "/teacher/schedule",
    },
    {
      id: 7,
      name: t("User"),
      activeIcon: "/img/teacher-sidebar/user-active.svg",
      inactiveIcon: "/img/teacher-sidebar/user.svg",
      path: "/teacher/user",
    },
  ];

  const isActiveRoute = (menuPath) => {
    console.log(menuPath, pathname);

    if (menuPath === "/teacher") {
      return pathname === "/teacher";
    }
    return pathname.startsWith(menuPath);
  };

  return (
    <section className="fixed flex h-screen w-[16.975rem] flex-col items-center border border-[#4D44B5] border-r-[#F3F4FF] bg-[#4D44B5] pt-8">
      <Link
        to="/teacher"
        className="flex h-[2.88656rem] items-center pl-6 justify-center gap-2"
      >
        <img src="/img/logo.svg" alt="logo" height={45} width={45} />
        <h1 className="font-poppins lead text-[2rem] font-bold text-white">
          {t("Title")}
        </h1>
      </Link>

      <nav className="mt-4 flex flex-col gap-2 pl-4 w-full">
        {menuItems.map((menu) => (
          <Link
            to={menu.path}
            key={menu.id}
            className={`group w-full flex items-center gap-6 rounded-s-[2.5rem] px-6 py-2 text-lg font-medium hover:bg-[#F3F4FF] hover:text-[#4D44B5] ${
              isActiveRoute(menu.path)
                ? "bg-[#F3F4FF] text-[#4D44B5]"
                : "text-[#C1BBEB]"
            }`}
          >
            <img
              src={
                isActiveRoute(menu.path) || false
                  ? menu.activeIcon
                  : menu.inactiveIcon
              }
              className={`${
                !isActiveRoute(menu.path) ? "group-hover:hidden" : ""
              }`}
              alt={menu.name}
            />
            {!isActiveRoute(menu.path) && (
              <img
                src={menu.activeIcon}
                className="hidden group-hover:block"
                alt={menu.name}
              />
            )}
            <h2>{menu.name}</h2>
          </Link>
        ))}
      </nav>
    </section>
  );
}

export default Sidebar;
