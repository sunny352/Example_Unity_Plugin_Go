using System;
using System.Runtime.InteropServices;
using UnityEngine;

public class Main : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        Debug.Log(GetTimeString());
        Debug.Log(GetNativeValue());
        Debug.Log(GetPlatformValue());
        Debug.Log(GetStr());
        SetStr("测试");
    }

    #region NativePlugin
    
#if UNITY_IOS && !UNITY_EDITOR
    [DllImport ("__Internal")]
#else
    [DllImport("NativePlugin")]
#endif
    private static extern long GetNativeValue();
    
#if UNITY_IOS && !UNITY_EDITOR
    [DllImport ("__Internal")]
#else
    [DllImport("NativePlugin")]
#endif
    private static extern IntPtr GetTime();    //获取IntPtr事实上是获取C内存中的地址，没有做任何操作，所以这块内存不需要的时候就要手动释放
    
#if UNITY_IOS && !UNITY_EDITOR
    [DllImport ("__Internal")]
#else
    [DllImport("NativePlugin")]
#endif
    private static extern void FreeStr(IntPtr str);
    
    private string GetTimeString()
    {
        var ptr = GetTime();
        var str = Marshal.PtrToStringAnsi(ptr);
        FreeStr(ptr);
        return str;
    }
    
#if UNITY_IOS && !UNITY_EDITOR
    [DllImport ("__Internal")]
#else
    [DllImport("NativePlugin")]
#endif
    [return: MarshalAs(UnmanagedType.LPUTF8Str)]    //使用这种方式加载字符串的时候，C的内存块会被P/Invoke释放，所以不用手动释放
    private static extern string GetStr();
    
#if UNITY_IOS && !UNITY_EDITOR
    [DllImport ("__Internal")]
#else
    [DllImport("NativePlugin")]
#endif
    private static extern void SetStr([MarshalAs(UnmanagedType.LPUTF8Str)]string str);    //使用这种方式加载字符串的时候，C的内存块会被P/Invoke释放，所以不用手动释放

    #endregion

    #region PlatformPlugin

#if UNITY_EDITOR
    private static long GetPlatformValue()
    {
        return 0;
    }
#else
#if UNITY_ANDROID
    private static long GetPlatformValue()
    {
        try
        {
            var unityPlugin = new AndroidJavaClass("PlatformPlugin.PlatformPlugin");
            return unityPlugin.CallStatic<long>("getPlatformValue");
        }
        catch (Exception e)
        {
            Debug.LogException(e);
            return 0;
        }
    }
#elif UNITY_IOS 
    [DllImport ("__Internal")]
    private static extern long PlatformPluginGetPlatformValue();
    private static long GetPlatformValue()
    {
        return PlatformPluginGetPlatformValue();
    }
#endif
#endif

    #endregion

    
}