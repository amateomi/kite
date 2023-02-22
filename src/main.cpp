#include "Browser.hpp"

int main(const int argc, char* argv[])
{
    const Browser browser { argc, argv };
    return browser.run();
}